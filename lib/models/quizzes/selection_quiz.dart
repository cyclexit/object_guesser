import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';

class Selection {
  Label label;
  ImageData image;

  Selection({required this.label, required this.image});
}

class SelectionQuiz extends Quiz {
  String id;
  List<Selection> selections;
  List<Selection> correctAnswer;
  List<Selection>? _answer;

  SelectionQuiz(
      {required this.id,
      required this.selections,
      required this.correctAnswer});

  @override
  List<Selection>? get answer {
    return _answer;
  }

  @override
  set answer(dynamic answer) {
    _answer = answer as List<Selection>;
  }
}