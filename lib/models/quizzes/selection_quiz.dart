import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';

class SelectionAnswer {
  final ImageData image;
  final int points;

  SelectionAnswer({required this.image, required this.points});

  SelectionAnswer.fromJson(Map<String, dynamic> json)
      : image = ImageData.fromJson(json["image"]),
        points = json["points"];
}

class SelectionQuiz extends Quiz {
  final Label label;
  final List<ImageData> selections;
  final Map<String, SelectionAnswer> correctAnswers;
  final int maxPoints;
  List<ImageData>? _answer;

  SelectionQuiz(
      {required super.id,
      required this.label,
      required this.selections,
      required this.correctAnswers,
      required this.maxPoints});

  SelectionQuiz.fromJson(Map<String, dynamic> json)
      : label = Label.fromJson(json["label"]),
        selections = List.from(json["selections"]!)
            .map((selection) => ImageData.fromJson(selection))
            .toList(),
        correctAnswers = {
          for (var jsonAnswer in List.from(json["correct_answers"]!))
            jsonAnswer["image"]["id"]: SelectionAnswer.fromJson(jsonAnswer)
        },
        maxPoints = json["max_points"],
        super(id: json["id"].toString());

  Map<String, dynamic> toJSON() => {
        "id": id,
        "label": label.toJson(),
        "selections": selections,
        "correct_answers": correctAnswers.entries.toList(),
        "max_points": maxPoints,
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

  @override
  bool isAnswerSet() {
    return _answer != null && _answer!.isNotEmpty;
  }

  @override
  int getPoints() {
    int points = 0;
    if (isAnswerSet()) {
      for (var selectedAnswer in answer!) {
        var correctAnswer = correctAnswers[selectedAnswer.id];
        if (correctAnswer != null) {
          points += correctAnswer.points;
        }
      }
    }
    return points;
  }
}
