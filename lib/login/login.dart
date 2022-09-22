import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/home'),
          child: const Text("Login"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/about'),
          child: const Text("About"),
        ),
      ]),
    );
  }
}
