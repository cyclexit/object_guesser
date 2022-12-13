import 'package:flutter/material.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/provider/quiz_provider.dart';
import 'package:object_guesser/widgets/quiz_body/quiz_body.dart';
import 'package:object_guesser/widgets/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/user_input_form.dart';
import 'package:provider/provider.dart';

class InputBody extends StatelessWidget {
  final InputQuiz quiz;

  const InputBody({super.key, required this.quiz});

  Function(String?) setAnswer(BuildContext context) {
    return (String? userInput) =>
        Provider.of<QuizProvider>(context, listen: false)
            .setAnswer(quiz, userInput);
  }

  @override
  Widget build(BuildContext context) {
    return QuizBody(
      type: const QuizTypeText(quizTypeInfo: input),
      image: QuizImage(image: quiz.image),
      bottomArea:
          UserInputForm(onSaved: setAnswer(context), answer: quiz.answer),
    );
  }
}
