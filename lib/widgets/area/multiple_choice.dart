import 'package:flutter/material.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/widgets/choice_list.dart';
import 'package:object_guesser/widgets/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';

class MultipleChoice extends StatelessWidget {
  final MultipleChoiceQuiz quiz;

  const MultipleChoice({super.key, required this.quiz});

  void setAnswer(Label? choice) {
    quiz.answer = choice;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          height: 15.0,
        ),
        const QuizTypeText(quizTypeInfo: multipleChoice),
        const SizedBox(
          height: 30.0,
        ),
        QuizImage(image: quiz.image),
        const SizedBox(
          height: 15.0,
        ),
        ChoiceList(setAnswer: setAnswer, choices: quiz.choices)
      ]),
    );
  }
}
