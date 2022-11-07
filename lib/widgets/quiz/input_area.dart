import 'package:flutter/material.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';

class InputArea extends StatelessWidget {
  final InputQuiz quiz;

  const InputArea({super.key, required this.quiz});

  void setAnswer(String? userInput) {
    quiz.answer = userInput;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
