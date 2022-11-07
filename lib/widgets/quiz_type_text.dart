import 'package:flutter/material.dart';

import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/quizzes/quiz_type_info.dart';

class QuizTypeText extends StatelessWidget {
  final QuizTypeInfo quizTypeInfo;
  const QuizTypeText({super.key, required this.quizTypeInfo});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: blackColor, borderRadius: BorderRadius.circular(2.0)),
        constraints: const BoxConstraints(minWidth: 200.0),
        child: Tooltip(
          message: quizTypeInfo.description,
          triggerMode: TooltipTriggerMode.tap,
          child: Text(
            quizTypeInfo.type,
            style: theme.textTheme.subtitle1?.apply(color: whiteColor),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
