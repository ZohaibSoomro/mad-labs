import 'package:flutter/material.dart';

class GetMessagePage extends StatefulWidget {
  const GetMessagePage({Key? key}) : super(key: key);

  @override
  State<GetMessagePage> createState() => _GetMessagePageState();
}

class _GetMessagePageState extends State<GetMessagePage> {
  String message = "Default Message";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message),
          SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width,
          ),
          ElevatedButton(
            onPressed: () async {
              var msg = await Navigator.pushNamed(context, '/submit');
              if (msg != null) {
                setState(() {
                  message = msg.toString();
                  print("Got $msg");
                });
              }
            },
            child: const Text('GetMessage'),
          )
        ],
      ),
    );
  }
}
