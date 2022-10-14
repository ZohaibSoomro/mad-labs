import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final _formKey = GlobalKey<FormState>();
  String? emailAddress, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        // key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login.",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: buildTextFieldDecoration('YOUR EMAIL ADDRESS'),
                onChanged: ((value) {
                  setState(() {
                    emailAddress = value;
                  });
                }),
                // validator: ((value) => (value == null || value.isEmpty)
                //     ? "Enter email address."
                //     : null),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: buildTextFieldDecoration("PASSWORD"),
                onChanged: ((value) {
                  setState(() {
                    password = value;
                  });
                }),
                // validator: (value) {
                //   return (value == null || value.isEmpty)
                //       ? "Enter password."
                //       : value.length < 6
                //           ? "Password should be at least 6 characters."
                //           : null;
                // },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         Future.delayed(const Duration(milliseconds: 1000),
                    //             () {
                    //           Navigator.pop(context);
                    //         });
                    //         return const AlertDialog(
                    //           content: Text('Login Successful.'),
                    //           title: Text('Info.'),
                    //         );
                    //       });
                    // }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('LOGIN'),
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
