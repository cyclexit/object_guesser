import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function loginMethod;

  const LoginButton(
      {super.key,
      required this.text,
      required this.iconData,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          iconData,
          color: whiteColor,
          size: 20,
        ),
        onPressed: () => loginMethod(),
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
