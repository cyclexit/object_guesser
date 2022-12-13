import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/quiz_list.dart';
import 'package:object_guesser/pages/error_page.dart';
import 'package:object_guesser/pages/loading_page.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/services/firestore_service.dart';
import 'package:object_guesser/widgets/buttons/next_button.dart';
import 'package:object_guesser/widgets/progress_bar.dart';
import 'package:object_guesser/widgets/quiz_container.dart';
import 'package:object_guesser/widgets/quiz_header.dart';
import 'package:provider/provider.dart';

class _GamePage extends StatelessWidget {
  final String gameId;
  final Category category;

  const _GamePage({required this.gameId, required this.category});

  void _exitQuiz(BuildContext context) {
    final quizList = Provider.of<QuizList>(context);
    if (quizList.isDone) {
      Timestamp finishTime = Timestamp.now();
      for (final quiz in quizList.quizzes) {
        FirestoreService().uploadUserQuizRecord(quiz.id, quiz.runtimeType,
            quiz.getPoints(), quiz.answer, finishTime);
      }
      FirestoreService().updateUserGameHistory(
          gameId, quizList.currentPoints, category.name, finishTime);
      if (quizList.validateUserPerformance()) {
        log.d("The user is validated for this game"); // debug
        FirestoreService().updateImageLabelRecords(quizList.quizzes);
      }
    }
    Navigator.popUntil(context, ModalRoute.withName(MainPage.routeName));
  }

  @override
  Widget build(BuildContext context) {
    final quizList = Provider.of<QuizList>(context);
    Widget body;
    if (quizList.isNotReady) {
      body = const Loader();
    } else if (quizList.isRunning) {
      body = Column(
        children: [
          SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // TODO: change API and use consumer
                  QuizHeader(
                    category: category,
                    exitQuiz: () => _exitQuiz(context),
                    points: quizList.currentPoints,
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
                  // TODO: replace this function with Consumer
                  _updateQuizBody(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: NextButton(handlePress: quizList.next),
                  ),
                ])),
          ),
        ],
      );
    } else if (quizList.isDone) {
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
                Text(quizList.currentPoints.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.apply(color: whiteColor)),
                ElevatedButton(
                    onPressed: () => _exitQuiz(context),
                    child: const Text("go back home"))
              ]));
    } else {
      body = const Center(child: Text("Oops! Something is wrong...🤡"));
    }
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary, body: body);
  }
}

class GamePage extends StatelessWidget {
  static const routeName = '/game';
  final Category category;
  final QuizList quizList = QuizList();

  GamePage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().getQuizzes(QuizList.totalQuizzes, category),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else if (snapshot.hasError) {
            return ErrorPage(errorMessage: snapshot.error.toString());
          } else if (snapshot.hasData) {
            final gameData = snapshot.data!;
            quizList.quizzes = gameData["quizzes"];
            return ChangeNotifierProvider(
              create: ((context) => quizList),
              child: _GamePage(gameId: gameData["game_id"], category: category),
            );
          }
          return ErrorPage(errorMessage: snapshot.toString());
        }));
  }
}
