import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quiz/quiz.dart';

class MultipleChoiceQuiz extends Quiz {
  String id;
  ImageData image;
  List<Label> choices;
  Label correctAnswer;
  Label? _answer;

  MultipleChoiceQuiz(
      {required this.id,
      required this.image,
      required this.choices,
      required this.correctAnswer});

  @override
  Label? get answer {
    return _answer;
  }

  @override
  set answer(dynamic answer) {
    _answer = answer as Label;
  }
}
