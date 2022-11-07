import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? file;
  bool isPicking = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share using Bluetooth'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (file != null)
              isPicking
                  ? Center(
                      child: Text('...'),
                    )
                  : file!.path.endsWith("png") ||
                          file!.path.endsWith("jpg") ||
                          file!.path.endsWith("jpeg")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.file(
                            file!,
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.height * 0.7,
                          ),
                        )
                      : Text(
                          'Name: ${getFileName(file!.path)}',
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.end,
                        ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _pickSingleFile();
              },
              child: const Text('Pick file'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: file == null ? null : _onShare,
              child: const Text('Share'),
            )
          ],
        ),
      ),
    );
  }

  toggleIsPicking() => setState(() => isPicking = !isPicking);

  String getFileName(String path) {
    return path.substring(file!.path.lastIndexOf("/") + 1);
  }

  _pickSingleFile() async {
    toggleIsPicking();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        this.file = file;
      });
    } else {
      // User canceled the picker
    }
    toggleIsPicking();
  }

  Future getBluetoothPermission() async {
    var permStatus = await Permission.bluetooth.status;
    if (permStatus == PermissionStatus.granted) return;
    permStatus = await Permission.bluetooth.request();
    print("Granted: ${permStatus.isGranted}");
  }

  Future<List<File>> _pickMultiFiles() async {
    toggleIsPicking();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      return files;
    } else {
      // User canceled the picker
      return [];
    }
    toggleIsPicking();
  }

  _onShare() async {
    // file = null;
    await getBluetoothPermission();
    final box = context.findRenderObject() as RenderBox?;
    final result = await Share.shareXFiles(
      [XFile(file!.path)],
      text: getFileName(file!.path),
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    print("Share status:${result.status}");
    if(result.status==ShareResultStatus.success){
      file=null;
    }
    setState(() {});
  }
}
