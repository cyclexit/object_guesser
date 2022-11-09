import 'package:flutter/material.dart';

class QuizBody extends StatelessWidget {
  final Widget quizType;
  final Widget quizImage;
  final Widget bottomArea;

  const QuizBody(
      {super.key,
      required this.quizType,
      required this.quizImage,
      required this.bottomArea});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 15.0,
      ),
      quizType,
      const SizedBox(
        height: 30.0,
      ),
      quizImage,
      const SizedBox(
        height: 15.0,
      ),
      bottomArea
    ]);
  }
}
