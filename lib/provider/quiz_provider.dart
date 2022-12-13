import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/services/firestore_service.dart';

class QuizProvider with ChangeNotifier {
  String gameId = "";
  List<Quiz> _quizzes = [];
  bool loading = false;

  QuizProvider();

  UnmodifiableListView<Quiz> get quizzes => UnmodifiableListView(_quizzes);
  set quizzes(List<Quiz> quizzes) {
    _quizzes = quizzes;
    notifyListeners();
  }

  Future<void> fetchQuizzes(int totalQuizzes, Category category) async {
    try {
      loading = true;
      notifyListeners();

      var response =
          await FirestoreService().getQuizzes(totalQuizzes, category);
      _quizzes = response["quizzes"];
      gameId = response["game_id"];

      loading = false;
      notifyListeners();
    } catch (error) {
      log.e(error);
    }
  }

  void setAnswer(Quiz quiz, dynamic answer) {
    final index = _quizzes.indexOf(quiz);
    _quizzes[index].answer = answer;
    notifyListeners();
  }
}
