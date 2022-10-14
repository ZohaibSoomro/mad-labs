import 'package:flutter/material.dart';

class SubmitPage extends StatefulWidget {
  const SubmitPage({Key? key}) : super(key: key);

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  String? msg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text('Enter message: '),
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() {
                      msg = value;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, msg);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
