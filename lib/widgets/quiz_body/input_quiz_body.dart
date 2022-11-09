import 'package:flutter/material.dart';
import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/widgets/quiz_body/quiz_body.dart';
import 'package:object_guesser/widgets/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/user_input_form.dart';

class InputQuizBody extends StatelessWidget {
  final InputQuiz quiz;

  const InputQuizBody({super.key, required this.quiz});

  void setAnswer(String? userInput) {
    quiz.answer = userInput;
  }

  @override
  Widget build(BuildContext context) {
    return QuizBody(
      quizType: const QuizTypeText(quizTypeInfo: multipleChoice),
      quizImage: QuizImage(image: quiz.image),
      bottomArea: const UserInputForm(),
    );
  }
}
