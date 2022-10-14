import 'package:flutter/material.dart';

class GetAndDisplayData extends StatefulWidget {
  const GetAndDisplayData({Key? key}) : super(key: key);

  @override
  State<GetAndDisplayData> createState() => _GetAndDisplayDataState();
}

class _GetAndDisplayDataState extends State<GetAndDisplayData> {
  final _formKey = GlobalKey<FormState>();
  String? fullName, emailAddress, rollNo, department, batch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Student Registration!",
                style: TextStyle(fontSize: 30),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration('FULL NAME'),
                onChanged: ((value) {
                  setState(() {
                    fullName = value;
                  });
                }),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration("ROLLNO"),
                onChanged: ((value) {
                  setState(() {
                    rollNo = value;
                  });
                }),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration('YOUR EMAIL ADDRESS'),
                onChanged: ((value) {
                  setState(() {
                    emailAddress = value;
                  });
                }),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration('DEPARTMENT'),
                onChanged: ((value) {
                  setState(() {
                    department = value;
                  });
                }),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration('BATCH'),
                onChanged: ((value) {
                  setState(() {
                    batch = value;
                  });
                }),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                  '$fullName\n$rollNo\n$emailAddress\n$department\n$batch'),
                              title: const Text('You have entered.'),
                            );
                          });
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('SIGN UP'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration buildTextFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      fillColor: const Color.fromARGB(255, 49, 54, 57),
      filled: true,
    );
  }
}
