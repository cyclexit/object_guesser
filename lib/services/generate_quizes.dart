import 'dart:developer' as developer;
import 'dart:math';

import 'package:object_guesser/models/quiz/quiz.dart';
import 'package:object_guesser/constants/quiz_types.dart';

Quiz? generateOneQuiz() {
  // TODO: implement this
  switch (Random().nextInt(quizTypeInfoMap.length)) {
    case 0:
      return null;
    case 1:
      return null;
    case 2:
      return null;
    default:
      developer.log("Unknown Quiz Type.");
      return null;
  }
}

List<Quiz> generateQuizes(int totalQuiz) {
  List<Quiz> quizList = [];
  for (int i = 0; i < totalQuiz; ++i) {
    // quizList.add(quizTypeList[0]());
  }
  return quizList;
}
