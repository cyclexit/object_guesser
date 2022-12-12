import 'package:flutter/material.dart';

import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/quiz_list.dart';
import 'package:object_guesser/pages/error_page.dart';
import 'package:object_guesser/pages/loading_page.dart';
import 'package:object_guesser/services/firestore_service.dart';
import 'package:provider/provider.dart';

class _GamePage extends StatelessWidget {
  final String gameId;
  final Category category;

  const _GamePage({required this.gameId, required this.category});

  @override
  Widget build(BuildContext context) {
    final quizList = Provider.of<QuizList>(context);
    if (quizList.isNotReady) {
      return const LoadingPage();
    } else if (quizList.isRunning) {}
    return const ErrorPage(errorMessage: "Unkown QuizList state");
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
          return const ErrorPage(
              errorMessage: "Oops! Something unkown happened...");
        }));
  }
}
