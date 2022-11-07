import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/constants/quiz_types.dart';

Future<List<Quiz>> getQuizzes(int totalQuizzes) async {
  // Future: use totalQuizzes to query the quizzes data from sever first
  dynamic jsonData =
      jsonDecode(await rootBundle.loadString('data/mock_game.json'));
  if (jsonData["quizzes"] == null) {
    log.e("Empty data for quizzes");
    return [];
  }
  if (jsonData["quizzes"].length != totalQuizzes) {
    log.e("Incorrect quiz number ${jsonData["quizzes"].length}, "
        "should be $totalQuizzes");
    return [];
  }
  List<Quiz> quizzes = [];
  dynamic quizJsonData;
  for (int i = 0; i < jsonData["quizzes"].length; ++i) {
    quizJsonData = jsonData["quizzes"][i];
    if (quizJsonData["type"] == null) {
      log.e("Quiz type is null");
      return [];
    }
    if (quizJsonData["type"] == multipleChoice.type) {
      quizzes.add(MultipleChoiceQuiz.fromJson(quizJsonData));
    } else if (quizJsonData["type"] == input.type) {
      quizzes.add(InputQuiz.fromJson(quizJsonData));
    }
  }
  return quizzes;
}
