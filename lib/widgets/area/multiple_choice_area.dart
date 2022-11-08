import 'package:flutter/material.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/widgets/area/scrollable_area.dart';
import 'package:object_guesser/widgets/choice_list.dart';
import 'package:object_guesser/widgets/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';

class MultipleChoiceArea extends StatelessWidget {
  final MultipleChoiceQuiz quiz;

  const MultipleChoiceArea({super.key, required this.quiz});

  void setAnswer(Label? choice) {
    quiz.answer = choice;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableArea(
        top: const QuizTypeText(quizTypeInfo: multipleChoice),
        middle: QuizImage(image: quiz.image),
        bottom: ChoiceList(setAnswer: setAnswer, choices: quiz.choices));
  }
}
