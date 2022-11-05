import 'package:flutter/material.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizes/input_quiz.dart';
import 'package:object_guesser/models/quizes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizes/quiz.dart';
import 'package:object_guesser/services/get_quizes.dart';
import 'package:object_guesser/widgets/buttons/button.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/choice_list.dart';
import 'package:object_guesser/widgets/quiz_container.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const int _totalQuizes = 2;
  List<Quiz> _quizes = [];
  bool _isDataReady = false;
  late int _idx;

  void setAnswer(Label? choice) {}
  void submitAnswer() {}

  Widget _updateUserAnswerArea() {
    Type quizType = _quizes[_idx].runtimeType;
    if (quizType == MultipleChoiceQuiz) {
      MultipleChoiceQuiz quiz = _quizes[_idx] as MultipleChoiceQuiz;
      return ChoiceList(setAnswer: setAnswer, choices: quiz.choices);
    } else if (quizType == InputQuiz) {
      // TODO: implement the user typing input form
      return const Text("Sorry not yet...");
    }
    return const SizedBox(height: 0);
  }

  @override
  void initState() {
    super.initState();
    Future<List<Quiz>> future = getQuizes(_totalQuizes);
    future.then((value) {
      _quizes = value;
      setState(() {
        _idx = 0;
        _isDataReady = true;
      });
      // log.d(_quizes);
    }, onError: (error) {
      log.e(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    if (!_isDataReady) {
      page = Scaffold(
          appBar: AppBar(),
          body: const Center(
              child: Text(
            "Loading....",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          )));
    } else if (_idx < _totalQuizes) {
      page = Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: QuizContainer(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_isDataReady)
                      QuizTypeText(
                          quizTypeInfo:
                              quizTypeInfoMap[_quizes[_idx].runtimeType]!),
                    const SizedBox(
                      height: 15.0,
                    ),
                    // TODO: update this part based on the question type
                    if (_isDataReady) _updateUserAnswerArea(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    // TODO: pass the next quiz function as the onPressed handler
                    Button(
                        text: "Next",
                        icon: Icons.arrow_forward,
                        onPressed: (() => setState(() {
                              ++_idx;
                            }))),
                    const SizedBox(
                      height: 35.0,
                    ),
                  ]),
            ),
          ));
    } else {
      page = Scaffold(
          appBar: AppBar(),
          body: const Center(
              child: Text(
            "Finish the quiz!!!",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          )));
    }
    return page;
  }
}
