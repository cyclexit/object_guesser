import 'package:flutter/material.dart';
import 'package:object_guesser/pages/main_page.dart';

const _heightGap = SizedBox(
  height: 10,
);

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

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
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, MainPage.routeName, (route) => false),
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
