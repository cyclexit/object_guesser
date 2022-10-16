import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';

class ChoiceButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool active;

  const ChoiceButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.active = false});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          textStyle: theme.textTheme.headline2,
          foregroundColor: active ? whiteColor : blackColor,
          backgroundColor: active ? theme.colorScheme.primary : whiteColor,
          elevation: active ? 0 : 5.0),
      child: Text(text),
    );
  }
}
