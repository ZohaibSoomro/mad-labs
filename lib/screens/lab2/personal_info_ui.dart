import 'package:flutter/material.dart';

class PersonalInfoUI extends StatelessWidget {
  const PersonalInfoUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              'My Info.',
              style: TextStyle(fontSize: 50),
            ),
          ),
          Text(
            '     Name: Zohaib Hassan',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            '     Rollno: 19SW42',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Department: Software',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Batch: 19',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            '  Domicile: Ghotki',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
