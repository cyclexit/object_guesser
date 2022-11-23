import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';

class InputAnswer {
  final Label label;
  final int points;

  InputAnswer({required this.label, required this.points});

  InputAnswer.fromJson(Map<String, dynamic> json)
      : label = Label.fromJson(json["label"]),
        points = json["points"];

  Map<String, dynamic> toJson() => {"label": label.toJson(), "points": points};
}

class InputQuiz extends Quiz {
  String id;
  ImageData image;

  // List of possible answer for the input.
  // This can be null since an Input Quiz
  // could be an `Unlabelled` Image.
  List<InputAnswer>? correctAnswers;
  String _answer = "";

  InputQuiz({
    required this.id,
    required this.image,
    this.correctAnswers,
  });

  InputQuiz.fromJson(Map<String, dynamic> json)
      : id = json['id']!.toString(),
        image = ImageData.fromJson(json["image"]),
        correctAnswers = json["correct_answers"] != null
            ? List.from(json["correct_answers"]!)
                .map((labelJson) => InputAnswer.fromJson(labelJson))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image.toJson(),
        "correct_answers": correctAnswers ?? [],
        "_answer": _answer,
      };

  @override
  String get answer {
    return _answer;
  }

  @override
  set answer(dynamic answer) {
    _answer = answer as String;
  }

  @override
  bool isAnswerSet() {
    return _answer.isNotEmpty;
  }

  @override
  int getPoints() {
    if (isAnswerSet() && correctAnswers == null) {
      return 50;
    } else if (isAnswerSet()) {
      for (var correctAnswer in correctAnswers!) {
        if (correctAnswer.label.name == answer) {
          return correctAnswer.points;
        }
      }
    }
    return 0;
  }
}
