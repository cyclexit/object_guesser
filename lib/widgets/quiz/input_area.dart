import 'package:flutter/material.dart';
import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/widgets/quiz/area.dart';
import 'package:object_guesser/widgets/quiz/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/user_input_form.dart';

class InputArea extends StatelessWidget {
  final InputQuiz quiz;

  const InputArea({super.key, required this.quiz});

  void setAnswer(String? userInput) {
    quiz.answer = userInput;
  }

  @override
  Widget build(BuildContext context) {
    return Area(
      quizTypeText: const QuizTypeText(quizTypeInfo: input),
      quizImage: QuizImage(image: quiz.image),
      lastArea: const UserInputForm(),
    );
  }
}
