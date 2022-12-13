import 'package:flutter/foundation.dart';

import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';

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

  /// Validate the user performance in this game.
  ///
  /// Calculate the points acquired by the user for `MultipleChoiceQuiz` and
  /// `SelectionQuiz` as `userValidationPoints`.
  ///
  /// If `userValidationPoints` / `totalMaxPoints` >= 0.5, then the user game
  /// performance is considered as valid.
  bool validateUserPerformance() {
    const double validationRatio = 0.5;
    int totalMaxPoints = 0;
    int userValidationPoints = 0;
    for (final quiz in _quizzes) {
      if (quiz.runtimeType == MultipleChoiceQuiz) {
        final q = quiz as MultipleChoiceQuiz;
        totalMaxPoints += q.maxPoints;
        userValidationPoints += q.getPoints();
      } else if (quiz.runtimeType == SelectionQuiz) {
        final q = quiz as SelectionQuiz;
        totalMaxPoints += q.maxPoints;
        userValidationPoints += q.getPoints();
      }
    }
    return (userValidationPoints / totalMaxPoints) >= validationRatio;
  }
}
