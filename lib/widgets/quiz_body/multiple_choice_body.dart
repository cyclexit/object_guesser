import 'package:flutter/material.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/widgets/choice_list.dart';
import 'package:object_guesser/widgets/quiz_body/quiz_body.dart';
import 'package:object_guesser/widgets/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';

class MultipleChoiceBody extends StatelessWidget {
  final MultipleChoiceQuiz quiz;

  const MultipleChoiceBody({super.key, required this.quiz});

  void setAnswer(Label? choice) {
    quiz.answer = choice;
  }

  @override
  Widget build(BuildContext context) {
    return QuizBody(
      type: const QuizTypeText(quizTypeInfo: multipleChoice),
      image: QuizImage(image: quiz.image),
      bottomArea: ChoiceList(setAnswer: setAnswer, choices: quiz.choices),
    );
  }
}
