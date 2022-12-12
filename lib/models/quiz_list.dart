import 'package:flutter/foundation.dart';

import 'package:object_guesser/models/quizzes/quiz.dart';

class QuizList extends ChangeNotifier {
  static const int totalQuizzes = 10;
  late int _idx;
  final List<Quiz> _quizzes = [];

  bool get ready => _quizzes.isNotEmpty;
  bool get done => _idx >= _quizzes.length;
  Quiz get currentQuiz => _quizzes[_idx];

  set quizzes(List<Quiz> quizzes) {
    _idx = 0;
    _quizzes.addAll(quizzes);
    notifyListeners();
  }

  void next() {
    ++_idx;
    notifyListeners();
  }
}
