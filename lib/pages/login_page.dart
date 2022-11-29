import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:object_guesser/config/object_guesser_icons.dart';
import 'package:object_guesser/config/themes.dart';

import 'package:object_guesser/services/auth.dart';
import 'package:object_guesser/widgets/buttons/login_button.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                ObjectGuesserIcons.logo,
                color: whiteColor,
                size: 128.0,
              ),
              const SizedBox(height: 12),
              Text("ObjectGuesser",
                  style: Theme.of(context).textTheme.headline1),
              const SizedBox(height: 24),
              LoginButton(
                  text: "Sign in with Google",
                  iconData: FontAwesomeIcons.google,
                  loginMethod: AuthService().googleLogin),
              // const SizedBox(height: 20),
              LoginButton(
                  text: "Sign in as Guest",
                  iconData: Icons.person,
                  loginMethod: AuthService().anonymousLogin),
            ]),
      ),
    );
  }
}
