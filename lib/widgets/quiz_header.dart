import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/category.dart';

class QuizHeader extends StatelessWidget {
  final Category category;
  final VoidCallback exitQuiz;
  final int points;

  const QuizHeader(
      {super.key,
      required this.category,
      required this.exitQuiz,
      required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: exitQuiz,
              child: const Icon(
                FluentIcons.dismiss_12_filled,
                color: whiteColor,
                size: 24.0,
              ),
            ),
          ),
          Text(
            category.name,
            style:
                Theme.of(context).textTheme.subtitle1?.apply(color: whiteColor),
          ),
          Positioned(
            right: 0,
            child: Text('$points pts',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.apply(color: whiteColor)),
          ),
        ],
      ),
    );
  }
}
