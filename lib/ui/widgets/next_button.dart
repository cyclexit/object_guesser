import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final void Function()? onPressed;

  const NextButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ElevatedButton(onPressed: onPressed, child: const Text("Next →")),
    );
  }
}
