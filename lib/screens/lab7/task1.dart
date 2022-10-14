// import 'dart:io';
// import 'dart:isolate';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_file_downloader/flutter_file_downloader.dart';
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int downloadProgress = 0;
//   final url = 'https://tinypng.com/images/social/website.jpg';
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: LinearProgressIndicator(
//               value: downloadProgress.toDouble(),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text('Progress: $downloadProgress'),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           downloadFileWithUrl(url);
//         },
//         child: const Icon(Icons.download),
//       ),
//     );
//   }
//
//   void onFabPressed() async {
//     Isolate.spawn(downloadFileWithUrl, url);
//     for (int i = 0; i < 10; i++) {
//       debugPrint('debug print: #$i');
//     }
//   }
//
//   void downloadFileWithUrl(String url) {
//     FileDownloader.downloadFile(
//       url: url, //"https://tinypng.com/images/social/website.jpg",
//       name: "PANDA",
//       onDownloadCompleted: (path) {
//         final File file = File(path);
//         print(file.path);
//         setState(() {
//           downloadProgress = 100;
//         });
//       },
//       onProgress: (_, progress) async {
//         print(progress);
//         if (progress == 45.0) {
//           await Future.delayed(const Duration(seconds: 1));
//         }
//         setState(() {
//           downloadProgress = progress.toInt();
//         });
//       },
//       onDownloadError: (error) {
//         debugPrint("Download Error:$error");
//       },
//     );
//   }
// }
