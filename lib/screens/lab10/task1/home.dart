import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 10'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Select an option to contact me',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton.icon(
              onPressed: onSendEmail,
              icon: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Icon(Icons.mail),
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('Email'),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton.icon(
              onPressed: onSendSms,
              icon: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Icon(Icons.sms),
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text('SMS'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSendSms() async {
    try {
      Uri uri = Uri.parse("sms:03131353150");
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint("SMS Error: $e");
    }
  }

  void onSendEmail() async {
    try {
      Uri uri = Uri.parse("mailto:zohaibsoomro006");
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint("Email Error: $e");
    }
  }
}
