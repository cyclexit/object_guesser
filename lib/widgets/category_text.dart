import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/quiz/quiz_type_info.dart';

class QuizTypeTooltip extends StatelessWidget {
  final QuizTypeInfo quizTypeInfo;
  const QuizTypeTooltip({super.key, required this.quizTypeInfo});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: blackColor, borderRadius: BorderRadius.circular(2.0)),
      constraints: const BoxConstraints(minWidth: 200.0),
      child: Text(
        quizTypeInfo.quizType,
        style: theme.textTheme.subtitle1?.apply(color: whiteColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
