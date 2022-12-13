import 'package:flutter/foundation.dart';

import 'package:object_guesser/models/quizzes/quiz.dart';

class QuizList extends ChangeNotifier {
  static const int totalQuizzes = 10;
  int _idx = 0;
  int _currentPoints = 0;
  final List<Quiz> _quizzes = [];

  bool get isNotReady => _quizzes.isEmpty;
  bool get isReady => _quizzes.isNotEmpty;
  bool get isRunning => _idx < _quizzes.length;
  bool get isDone => _idx >= _quizzes.length;
  List<Quiz> get quizzes => _quizzes;
  Quiz get currentQuiz => _quizzes[_idx];
  int get currentIndex => _idx;
  int get currentPoints => _currentPoints;

  set quizzes(List<Quiz> quizzes) {
    _quizzes.addAll(quizzes);
    notifyListeners();
  }

  void next() {
    _currentPoints += _quizzes[_idx++].getPoints();
    notifyListeners();
  }
}
