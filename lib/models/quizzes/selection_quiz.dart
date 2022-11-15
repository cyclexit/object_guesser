import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';

class SelectionQuiz extends Quiz {
  String id;
  Label label;
  List<ImageData> selections;
  List<ImageData> correctAnswers;
  List<ImageData>? _answer;

  SelectionQuiz(
      {required this.id,
      required this.label,
      required this.selections,
      required this.correctAnswers});

  SelectionQuiz.fromJson(Map<String, dynamic> json)
      : id = json["id"].toString(),
        label = Label.fromJson(json["label"]),
        selections = List.from(json["selections"]!)
            .map((selection) => ImageData.fromJson(selection))
            .toList(),
        correctAnswers = List.from(json["correctAnswers"]!)
            .map((selection) => ImageData.fromJson(selection))
            .toList();

  Map<String, dynamic> toJSON() => {
        "id": id,
        "label": label.toJson(),
        "selections": selections,
        "correctAnswers": correctAnswers,
        "answer": _answer ?? [],
      };

  @override
  List<ImageData>? get answer {
    return _answer;
  }

  @override
  set answer(dynamic answer) {
    _answer = answer as List<ImageData>;
  }
}
