import 'package:flutter/material.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/provider/quiz_provider.dart';
import 'package:object_guesser/widgets/choice_list.dart';
import 'package:object_guesser/widgets/quiz_body/quiz_body.dart';
import 'package:object_guesser/widgets/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:provider/provider.dart';

class MultipleChoiceBody extends StatelessWidget {
  final MultipleChoiceQuiz quiz;

  const MultipleChoiceBody({super.key, required this.quiz});

  Function(Label?) setAnswer(BuildContext context) {
    return (Label? choice) => Provider.of<QuizProvider>(context, listen: false)
        .setAnswer(quiz, choice);
  }

  int answerIndex() {
    if (quiz.answer != null) {
      return quiz.choices.indexOf(quiz.answer!);
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return QuizBody(
      type: const QuizTypeText(quizTypeInfo: multipleChoice),
      image: QuizImage(image: quiz.image),
      bottomArea: ChoiceList(
          setAnswer: setAnswer(context),
          choices: quiz.choices,
          selectedIndex: answerIndex()),
    );
  }
}
