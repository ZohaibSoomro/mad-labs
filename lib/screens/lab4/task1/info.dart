import 'package:flutter/material.dart';

import 'user.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  User? user;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        user = ModalRoute.of(context)!.settings.arguments as User;
        print(user);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Info.',
              style: TextStyle(fontSize: 50),
            ),
          ),
          Text(
            'Username: ${user!.username}',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'Email: ${user!.email}',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
