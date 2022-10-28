import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData? icon = null;
  final VoidCallback handlePress;

  const Button(
      {super.key, required this.text, icon, required this.handlePress});

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
              padding: const EdgeInsets.symmetric(horizontal: 44.0),
              child: Text(text),
            ),
            if (icon != null) Icon(icon)
          ],
        ));
  }
}
