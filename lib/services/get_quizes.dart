import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:object_guesser/models/quiz/quiz.dart';
import 'package:object_guesser/constants/quiz_types.dart';

Future<List<Quiz>> getQuizes(int totalQuizes) async {
  Logger log = Logger();

  dynamic jsonData =
      jsonDecode(await rootBundle.loadString('data/mock_game.json'));
  if (jsonData["quizes"] == null) {
    log.e("Empty data for quizes");
    return [];
  }
  // TODO: parse the data to quiz objects
  List<String> quizesMetaData = [];
  for (int i = 0; i < jsonData["quizes"].length; ++i) {
    quizesMetaData.add(jsonData["quizes"][i].toString());
    log.v(quizesMetaData[i]);
  }
  List<Quiz> quizes = [];
  for (int i = 0; i < totalQuizes; ++i) {
    // quizes.add(quizTypeList[0]());
  }
  return quizes;
}
