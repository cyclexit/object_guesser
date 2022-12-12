import 'package:flutter/material.dart';

import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/quiz_list.dart';
import 'package:object_guesser/pages/error_page.dart';
import 'package:object_guesser/pages/loading_page.dart';
import 'package:object_guesser/pages/quiz_page.dart';
import 'package:object_guesser/services/firestore_service.dart';
import 'package:provider/provider.dart';

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
          if (snapshot.hasError) {
            return ErrorPage(errorMessage: snapshot.error.toString());
          } else if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: ((context) => quizList),
              // TODO: update the API of QuizPage to QuizPage(gameId, category);
              child: QuizPage(category: category),
            );
          }
          return const LoadingPage();
        }));
  }
}
