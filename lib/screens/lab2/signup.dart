import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? fullName, emailAddress, password, confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Sign Up. It's free!",
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
                decoration: buildTextFieldDecoration('YOUR EMAIL ADDRESS'),
                onChanged: ((value) {
                  setState(() {
                    emailAddress = value;
                  });
                }),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration("PASSWORD"),
                onChanged: ((value) {
                  setState(() {
                    password = value;
                  });
                }),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration('CONFIRM PASSWORD'),
                onChanged: ((value) {
                  setState(() {
                    confirmPassword = value;
                  });
                }),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {},
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
