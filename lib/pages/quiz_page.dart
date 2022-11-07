import 'package:flutter/material.dart';

import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/services/get_quizzes.dart';
import 'package:object_guesser/widgets/buttons/next_button.dart';
import 'package:object_guesser/widgets/quiz/multiple_choice.dart';
import 'package:object_guesser/widgets/quiz_container.dart';

class QuizPage extends StatefulWidget {
  static const routeName = '/quiz';
  final Category category;

  const QuizPage({super.key, required this.category});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const int _totalQuizzes = 2;

  List<Quiz> _quizzes = [];
  bool _isDataReady = false;
  int _idx = 0;

  void _handleNextQuiz() {
    setState(() {
      ++_idx;
    });
  }

  Widget _updateQuiz() {
    Type quizType = _quizzes[_idx].runtimeType;
    if (quizType == MultipleChoiceQuiz) {
      return MultipleChoice(quiz: _quizzes[_idx] as MultipleChoiceQuiz);
    } else if (quizType == InputQuiz) {}
    return Container();
  }

  @override
  void initState() {
    super.initState();
    Future<List<Quiz>> future = getQuizzes(_totalQuizzes, widget.category);
    future.then((value) {
      _quizzes = value;
      setState(() {
        _isDataReady = true;
      });
    }, onError: (error) {
      log.e(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (!_isDataReady) {
      body = const Center(
          child: Text(
        "Loading....",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ));
    } else if (_idx < _totalQuizzes) {
      body = Column(
        children: [
          SafeArea(
            child: Text(widget.category.name,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.apply(color: whiteColor)),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: QuizContainer(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      _updateQuiz(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      NextButton(handlePress: _handleNextQuiz),
                    ]))),
          ),
        ],
      );
    } else {
      body = SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("End of Quiz",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.apply(color: whiteColor)),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, MainPage.routeName),
                    child: const Text("go back home"))
              ]));
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary, body: body);
  }
}
