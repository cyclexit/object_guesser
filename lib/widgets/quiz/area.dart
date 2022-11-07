import 'package:flutter/material.dart';
import 'package:object_guesser/widgets/quiz/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';

class Area extends StatelessWidget {
  final QuizTypeText quizTypeText;
  final Widget quizImage;
  final Widget lastArea;

  const Area(
      {super.key,
      required this.quizTypeText,
      required this.quizImage,
      required this.lastArea});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(flex: 1, child: quizTypeText),
        const SizedBox(height: 20),
        Flexible(flex: 6, child: quizImage),
        const SizedBox(height: 20),
        Flexible(flex: 3, child: lastArea)
      ],
    );
  }
}
