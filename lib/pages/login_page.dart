import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:object_guesser/services/auth.dart';
import 'package:object_guesser/widgets/buttons/login_button.dart';

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
                Image.asset('assets/icon/icon.png'),
                const SizedBox(height: 50),
                LoginButton(
                    text: "Sign in with Google",
                    iconData: FontAwesomeIcons.google,
                    loginMethod: AuthService().googleLogin),
                const SizedBox(height: 20),
                LoginButton(
                    text: "Sign in as Guest",
                    iconData: Icons.person,
                    loginMethod: AuthService().anonymousLogin),
              ]),
        ),
      ),
    );
  }
}
