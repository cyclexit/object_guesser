import 'package:flutter/material.dart';
import 'package:object_guesser/widgets/button/button.dart';

void nextQuiz() {
  // ignore: todo
  // TODO: implement this
}

class NextButton extends Button {
  const NextButton({super.key})
      : super(text: "Next", icon: Icons.arrow_forward, handlePress: nextQuiz);
}
