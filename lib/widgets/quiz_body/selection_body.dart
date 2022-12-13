import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';
import 'package:object_guesser/provider/quiz_provider.dart';
import 'package:object_guesser/widgets/quiz_body/quiz_body.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/selection_image.dart';
import 'package:provider/provider.dart';

class SelectionBody extends StatelessWidget {
  final SelectionQuiz quiz;

  const SelectionBody({super.key, required this.quiz});

  void onSelectionPress(BuildContext context, ImageData selection) {
    var selectedAnswers = quiz.answer;
    final index = selectedAnswers.indexOf(selection);
    if (index < 0) {
      selectedAnswers.add(selection);
    } else {
      selectedAnswers.removeAt(index);
    }
    Provider.of<QuizProvider>(context, listen: false)
        .setAnswer(quiz, selectedAnswers);
  }

  bool isSelected(ImageData selection) {
    return quiz.answer.contains(selection);
  }

  @override
  Widget build(BuildContext context) {
    return QuizBody(
      type: const QuizTypeText(quizTypeInfo: select),
      image: GridView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
        children: quiz.selections
            .asMap()
            .entries
            .map((entry) => SelectionImage(
                  image: entry.value,
                  onPress: () => onSelectionPress(context, entry.value),
                  isSelected: isSelected(entry.value),
                ))
            .toList(),
      ),
      bottomArea: Text(
        quiz.label.name,
        style: Theme.of(context).textTheme.headline1?.apply(color: blackColor),
      ),
    );
  }
}
