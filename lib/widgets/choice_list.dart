import 'package:flutter/material.dart';

import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/widgets/buttons/choice_button.dart';

class ChoiceList extends StatelessWidget {
  final void Function(Label?) setAnswer;
  final List<Label> choices;
  final int selectedIndex;

  const ChoiceList(
      {super.key,
      required this.setAnswer,
      required this.choices,
      this.selectedIndex = -1});

  void _onChoiceSelect(int index) {
    setAnswer(choices[index]);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 175 / 80,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15),
      children: choices.asMap().entries.map((entry) {
        var index = entry.key;
        var choice = entry.value;

        return ChoiceButton(
            text: choice.name,
            active: index == selectedIndex,
            onPressed: () => _onChoiceSelect(index));
      }).toList(),
    );
  }
}
