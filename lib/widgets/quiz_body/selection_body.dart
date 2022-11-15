import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';
import 'package:object_guesser/widgets/quiz_body/quiz_body.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/selection_image.dart';

class SelectionBody extends StatefulWidget {
  final SelectionQuiz quiz;

  const SelectionBody({super.key, required this.quiz});

  @override
  State<SelectionBody> createState() => _SelectionBodyState();
}

class _SelectionBodyState extends State<SelectionBody> {
  Map<String, ImageData> _selectedAnswers = {};

  void onSelectionPress(ImageData selection) {
    if (_selectedAnswers[selection.id] == null) {
      _selectedAnswers[selection.id] = selection;
    } else {
      _selectedAnswers.remove(selection.id);
    }

    setState(() {
      _selectedAnswers = _selectedAnswers;
    });
    widget.quiz.answer = _selectedAnswers.values.toList();
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
        children: widget.quiz.selections
            .asMap()
            .entries
            .map((entry) => SelectionImage(
                  image: entry.value,
                  onPress: () => onSelectionPress(entry.value),
                  isSelected: _selectedAnswers[entry.value.id] != null,
                ))
            .toList(),
      ),
      bottomArea: Text(
        widget.quiz.label.text,
        style: Theme.of(context).textTheme.headline1?.apply(color: blackColor),
      ),
    );
  }
}
