import 'package:flutter/material.dart';

class SignUpWithValidation extends StatefulWidget {
  const SignUpWithValidation({Key? key}) : super(key: key);

  @override
  State<SignUpWithValidation> createState() => _SignUpWithValidationState();
}

class _SignUpWithValidationState extends State<SignUpWithValidation> {
  final _formKey = GlobalKey<FormState>();
  String? fullName, emailAddress, password, confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
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
                validator: ((value) =>
                    (value == null || value.isEmpty) ? "Enter a name." : null),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration('YOUR EMAIL ADDRESS'),
                onChanged: ((value) {
                  setState(() {
                    emailAddress = value;
                  });
                }),
                validator: ((value) => (value == null || value.isEmpty)
                    ? "Enter email address."
                    : null),
              ),
              TextFormField(
                decoration: buildTextFieldDecoration("PASSWORD"),
                onChanged: ((value) {
                  setState(() {
                    password = value;
                  });
                }),
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? "Enter password."
                      : value.length < 6
                          ? "Password should be at least 6 characters."
                          : null;
                },
              ),
              TextFormField(
                decoration: buildTextFieldDecoration('CONFIRM PASSWORD'),
                onChanged: ((value) {
                  setState(() {
                    confirmPassword = value;
                  });
                }),
                validator: (value) => (value == null || value.isEmpty)
                    ? "Enter confirm password."
                    : value.length < 6
                        ? "Password should be at least 6 characters."
                        : password != confirmPassword
                            ? "Confirm password does not match with password."
                            : null,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              Navigator.pop(context);
                            });
                            return const AlertDialog(
                              content: Text('Form Submitted successfully.'),
                              title: Text('Info.'),
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
