import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quiz.dart';

class Selection {
  Label label;
  Image image;

  Selection({required this.label, required this.image});
}

class SelectionQuiz extends Quiz {
  String id;
  List<Selection> selections;
  List<Selection>? _answer;

  List<Selection> correctAnswer;

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
