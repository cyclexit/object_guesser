import 'package:flutter/material.dart';

import 'package:object_guesser/config/themes.dart';

class QuizContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  const QuizContainer({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: FractionalOffset.bottomCenter,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
            color: color ?? whiteColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 0,
                blurRadius: 12,
                offset: const Offset(0, -15),
              )
            ],
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30.0))),
        child: child);
  }
}
