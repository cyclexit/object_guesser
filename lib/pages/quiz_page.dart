import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';
import 'package:object_guesser/pages/loading_page.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/provider/quiz_provider.dart';
import 'package:object_guesser/services/firestore_service.dart';
import 'package:object_guesser/widgets/buttons/next_button.dart';
import 'package:object_guesser/widgets/progress_bar.dart';
import 'package:object_guesser/widgets/quiz_body/input_body.dart';
import 'package:object_guesser/widgets/quiz_body/multiple_choice_body.dart';
import 'package:object_guesser/widgets/quiz_body/selection_body.dart';
import 'package:object_guesser/widgets/quiz_container.dart';
import 'package:object_guesser/widgets/quiz_header.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  static const routeName = '/quiz';
  final Category category;

  const QuizPage({super.key, required this.category});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // NOTE: keep _totalQuizzes small for dev
  static const int _totalQuizzes = 10;

  int _idx = 0;
  int _points = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<QuizProvider>(context, listen: false)
        .fetchQuizzes(_totalQuizzes, widget.category));
  }

  void _handleNextQuiz(Quiz quiz) {
    setState(() {
      _points += quiz.getPoints();
      _idx++;
    });
  }

  Widget _updateQuizBody(Quiz quiz) {
    Type quizType = quiz.runtimeType;

    switch (quizType) {
      case MultipleChoiceQuiz:
        return MultipleChoiceBody(quiz: quiz as MultipleChoiceQuiz);
      case InputQuiz:
        return InputBody(quiz: quiz as InputQuiz);
      case SelectionQuiz:
        return SelectionBody(quiz: quiz as SelectionQuiz);
      default:
        log.e("Unknown quiz type!");
        return Container();
    }
  }

  /// Validate the user performance in this game.
  ///
  /// Calculate the points acquired by the user for `MultipleChoiceQuiz` and
  /// `SelectionQuiz` as `userValidationPoints`.
  ///
  /// If `userValidationPoints` / `totalMaxPoints` >= 0.5, then the user game
  /// performance is considered as valid.
  bool _validateUserPerformance(List<Quiz> quizzes) {
    const double validationRatio = 0.5;
    int totalMaxPoints = 0;
    int userValidationPoints = 0;
    for (final quiz in quizzes) {
      if (quiz.runtimeType == MultipleChoiceQuiz) {
        final q = quiz as MultipleChoiceQuiz;
        totalMaxPoints += q.maxPoints;
        userValidationPoints += q.getPoints();
      } else if (quiz.runtimeType == SelectionQuiz) {
        final q = quiz as SelectionQuiz;
        totalMaxPoints += q.maxPoints;
        userValidationPoints += q.getPoints();
      }
    }
    return (userValidationPoints / totalMaxPoints) >= validationRatio;
  }

  void _submitQuiz(BuildContext context) {
    Timestamp finishTime = Timestamp.now();
    var quizProvider = Provider.of<QuizProvider>(context, listen: false);
    var quizzes = quizProvider.quizzes;
    var gameId = quizProvider.gameId;

    for (final quiz in quizzes) {
      FirestoreService().uploadUserQuizRecord(quiz, finishTime);
    }
    FirestoreService().updateUserGameHistory(
        gameId, _points, widget.category.name, finishTime);
    if (_validateUserPerformance(quizzes)) {
      log.d("The user is validated for this game"); // debug
      FirestoreService().updateImageLabelRecords(quizzes);
    }

    Navigator.popUntil(context, ModalRoute.withName(MainPage.routeName));
  }

  void _exitQuiz(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(MainPage.routeName));
  }

  int _calculateScore(List<Quiz> quizzes) {
    int score = 0;

    for (var quiz in quizzes) {
      score += quiz.getPoints();
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    final quizProvider = Provider.of<QuizProvider>(context);
    var quizzes = quizProvider.quizzes;

    if (quizProvider.loading) {
      body = const LoadingPage();
    } else if (_idx < quizzes.length) {
      var quiz = quizzes[_idx];
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
                  ProgressBar(quizzes: quizzes, index: _idx)
                ],
              )),
          const SizedBox(height: 16.0),
          Expanded(
            child: QuizContainer(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  _updateQuizBody(quiz),
                  if (quiz.isAnswerSet())
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child:
                          NextButton(handlePress: () => _handleNextQuiz(quiz)),
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
                Text(_calculateScore(quizzes).toString(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.apply(color: whiteColor)),
                ElevatedButton(
                    onPressed: () => _submitQuiz(context),
                    child: const Text("go back home"))
              ]));
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary, body: body);
  }
}
