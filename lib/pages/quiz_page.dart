import 'package:flutter/material.dart';

import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';
import 'package:object_guesser/pages/loading_page.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/services/firestore_service.dart';
import 'package:object_guesser/widgets/buttons/next_button.dart';
import 'package:object_guesser/widgets/progress_bar.dart';
import 'package:object_guesser/widgets/quiz_body/input_body.dart';
import 'package:object_guesser/widgets/quiz_body/multiple_choice_body.dart';
import 'package:object_guesser/widgets/quiz_body/selection_body.dart';
import 'package:object_guesser/widgets/quiz_container.dart';
import 'package:object_guesser/widgets/quiz_header.dart';

class QuizPage extends StatefulWidget {
  static const routeName = '/quiz';
  final Category category;

  const QuizPage({super.key, required this.category});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // NOTE: keep _totalQuizzes small for dev
  static const int _totalQuizzes = 3;

  List<Quiz> _quizzes = [];
  bool _isDataReady = false;
  int _idx = 0;
  int _points = 0;

  @override
  void initState() {
    super.initState();
    Future<List<Quiz>> future =
        FirestoreService().getQuizzes(_totalQuizzes, widget.category);
    future.then((value) {
      setState(() {
        _quizzes = value;
        _isDataReady = true;
      });
    }, onError: (error) {
      log.e(error);
    });
  }

  void _handleNextQuiz() {
    setState(() {
      _points += _quizzes[_idx].getPoints();
      _idx++;
    });
  }

  Widget _updateQuiz() {
    Type quizType = _quizzes[_idx].runtimeType;
    Quiz quiz = _quizzes[_idx];

    switch (quizType) {
      case MultipleChoiceQuiz:
        return MultipleChoiceBody(quiz: quiz as MultipleChoiceQuiz);
      case InputQuiz:
        return InputBody(quiz: quiz as InputQuiz);
      case SelectionQuiz:
        return SelectionBody(quiz: quiz as SelectionQuiz);
    }
    return Container();
  }

  void _exitQuiz(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(MainPage.routeName));
  }

  int _calculateScore() {
    int score = 0;
    for (var quiz in _quizzes) {
      score += quiz.getPoints();
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (!_isDataReady) {
      body = const LoadingPage();
    } else if (_idx < _quizzes.length) {
      body = Column(
        children: [
          SafeArea(
              bottom: false,
              child: Column(
                children: [
                  QuizHeader(
                    category: widget.category,
                    exitQuiz: () => _exitQuiz(context),
                    points: _points,
                  ),
                  const SizedBox(height: 12.0),
                  ProgressBar(quizzes: _quizzes, index: _idx)
                ],
              )),
          const SizedBox(height: 16.0),
          Expanded(
            child: QuizContainer(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  _updateQuiz(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: NextButton(handlePress: _handleNextQuiz),
                  ),
                ])),
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
                Text(_calculateScore().toString(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.apply(color: whiteColor)),
                ElevatedButton(
                    onPressed: () => _exitQuiz(context),
                    child: const Text("go back home"))
              ]));
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary, body: body);
  }
}
