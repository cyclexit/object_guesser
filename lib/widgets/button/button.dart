import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback handlePress;

  const Button(
      {super.key, required this.text, this.icon, required this.handlePress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: handlePress,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Text(text),
            ),
            if (icon != null) Icon(icon)
          ],
        ));
  }
}
