import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/quiz/input_quiz.dart';
import 'package:object_guesser/models/quiz/multiple_choice_quiz.dart';
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
    log.e("Incorrect quiz number ${jsonData["quizes"].length}, "
        "should be $totalQuizes");
    return [];
  }
  List<Quiz> quizes = [];
  dynamic quizJsonData;
  for (int i = 0; i < jsonData["quizes"].length; ++i) {
    quizJsonData = jsonData["quizes"][i];
    if (quizJsonData["type"] == null) {
      log.e("Quiz type is null");
      return [];
    }
    if (quizJsonData["type"] == multipleChoice.quizType) {
      quizes.add(MultipleChoiceQuiz.fromJson(quizJsonData));
    } else if (quizJsonData["type"] == input.quizType) {
      quizes.add(InputQuiz.fromJson(quizJsonData));
    }
  }
  return quizes;
}
