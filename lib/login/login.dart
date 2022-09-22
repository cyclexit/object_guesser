import 'package:flutter/material.dart';

const _heightGap = SizedBox(
  height: 10,
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IntrinsicWidth(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                  child: const Text("Login"),
                ),
                _heightGap,
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/about'),
                  child: const Text("About"),
                ),
              ]),
        ),
      ),
    );
  }
}
