import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              'Info.',
              style: TextStyle(fontSize: 50),
            ),
          ),
          Text(
            'Employee Name: Khalid',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Department: Finance',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Job: Accountant',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Salary: 40000 PKR',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
