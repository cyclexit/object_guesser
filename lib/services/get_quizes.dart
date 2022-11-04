import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/quiz/quiz.dart';
import 'package:object_guesser/constants/quiz_types.dart';

Future<List<Quiz>> getQuizes(int totalQuizes) async {
  // Future: use totalQuizes to query the quizes data from sever first
  dynamic jsonData =
      jsonDecode(await rootBundle.loadString('data/mock_game.json'));
  if (jsonData["quizes"] == null) {
    log.e("Empty data for quizes");
    return [];
  }
  if (jsonData["quizes"].length != totalQuizes) {
    log.e("Incorrect quiz number");
    return [];
  }
  List<Quiz> quizes = [];
  dynamic quizData;
  for (int i = 0; i < jsonData["quizes"].length; ++i) {
    quizData = jsonData["quizes"][i];
    if (quizData["type"] == null) {
      log.e("Quiz type is null");
      return [];
    }
    if (quizData["type"] == multipleChoice.quizType) {
      // TODO: use json to create an object
    } else if (quizData["type"] == input.quizType) {
      // TODO: use json to create an object
    }
  }
  return quizes;
}
