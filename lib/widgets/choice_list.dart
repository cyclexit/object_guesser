import 'package:flutter/material.dart';

import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/widgets/buttons/choice_button.dart';

class ChoiceList extends StatefulWidget {
  final void Function(Label?) setAnswer;
  final List<Label> choices;

  const ChoiceList({super.key, required this.setAnswer, required this.choices});

  @override
  State<ChoiceList> createState() => _ChoiceListState();
}

class _ChoiceListState extends State<ChoiceList> {
  int _selectedIndex = -1;

  void _onChoiceSelect(int index) {
    if (index == _selectedIndex) {
      index = -1;
      widget.setAnswer(null);
    } else {
      widget.setAnswer(widget.choices[index]);
    }

    setState(() {
      _selectedIndex = index;
    });
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
      children: widget.choices.asMap().entries.map((entry) {
        var index = entry.key;
        var choice = entry.value;

        return ChoiceButton(
            text: choice.name,
            active: index == _selectedIndex,
            onPressed: () => _onChoiceSelect(index));
      }).toList(),
    );
  }
}
