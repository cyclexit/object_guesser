import 'package:flutter/material.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/widgets/category_text.dart';
import 'package:object_guesser/widgets/choice_list.dart';
import 'package:object_guesser/widgets/button/next_button.dart';
import 'package:object_guesser/widgets/quiz_container.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final labels = const [
    Label(id: "id1", text: "dog"),
    Label(id: "id2", text: "shih tzu"),
    Label(id: "id3", text: "cat"),
    Label(id: "id4", text: "horse"),
  ];

  void setAnswer(Label? choice) {}
  void submitAnswer() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 160.0),
        child: QuizContainer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CategoryText(category: "multiple choice"),
                const SizedBox(
                  height: 15.0,
                ),
                ChoiceList(setAnswer: setAnswer, choices: labels),
                const SizedBox(
                  height: 30.0,
                ),
                const NextButton(),
                const SizedBox(
                  height: 35.0,
                ),
              ]),
        ),
      ),
    );
  }
}
