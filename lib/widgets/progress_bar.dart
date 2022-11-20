import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';

class ProgressBar extends StatelessWidget {
  final List<Quiz> quizzes;
  final int index;

  Color getColorFromPoints(int points) {
    if (points >= 100) {
      return greenColor;
    } else if (points <= 0) {
      return Colors.red;
    } else {
      return tertiaryColor;
    }
  }

  const ProgressBar({super.key, required this.quizzes, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: quizzes.asMap().entries.map((entry) {
          var currentIndex = entry.key;
          var color = whiteColor;

          if (currentIndex > index) {
            color = secondaryColor;
          } else if (currentIndex < index) {
            color = getColorFromPoints(quizzes[currentIndex].getPoints());
          }

          return Icon(
            FontAwesomeIcons.minus,
            color: color,
            size: 32.0,
          );
        }).toList());
  }
}
