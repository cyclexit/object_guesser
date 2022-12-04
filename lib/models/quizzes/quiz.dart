abstract class Quiz {
  final String id;

  Quiz({required this.id});

  /// Get the Answer for the Quiz
  get answer {}

  /// Set the Answer for the Quiz
  set answer(dynamic answer) {}

  bool isAnswerSet();

  int getPoints();
}
