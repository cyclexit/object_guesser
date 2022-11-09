import 'package:flutter/material.dart';

class QuizBody extends StatelessWidget {
  final Widget type;
  final Widget image;
  final Widget bottomArea;

  const QuizBody(
      {super.key,
      required this.type,
      required this.image,
      required this.bottomArea});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 15.0,
      ),
      type,
      const SizedBox(
        height: 30.0,
      ),
      image,
      const SizedBox(
        height: 15.0,
      ),
      bottomArea
    ]);
  }
}
