import 'package:flutter/material.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/widgets/quiz_body/quiz_body.dart';
import 'package:object_guesser/widgets/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/user_input_form.dart';

class InputBody extends StatelessWidget {
  final InputQuiz quiz;

  const InputBody({super.key, required this.quiz});

  void setAnswer(String? userInput) {
    quiz.answer = userInput;
  }

  @override
  Widget build(BuildContext context) {
    return QuizBody(
      type: const QuizTypeText(quizTypeInfo: input),
      image: QuizImage(image: quiz.image),
      bottomArea: UserInputForm(onSaved: setAnswer),
    );
  }
}
