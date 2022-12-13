import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/quiz_list.dart';

class ProgressBar extends StatelessWidget {
  Color getColorFromPoints(int points) {
    if (points >= 100) {
      return greenColor;
    } else if (points <= 0) {
      return Colors.red;
    } else {
      return tertiaryColor;
    }
  }

  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizList>(
        builder: (context, quizList, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: quizList.quizzes.asMap().entries.map((entry) {
              var idx = entry.key;
              var color = whiteColor;

              if (idx > quizList.currentIndex) {
                color = secondaryColor;
              } else if (idx < quizList.currentIndex) {
                color = getColorFromPoints(entry.value.getPoints());
              }

              return Icon(
                FontAwesomeIcons.minus,
                color: color,
                size: 32.0,
              );
            }).toList()));
  }
}
