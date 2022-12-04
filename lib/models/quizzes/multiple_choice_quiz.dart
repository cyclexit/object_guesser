import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';

class MultipleChoiceAnswer {
  final Label label;
  final int points;

  MultipleChoiceAnswer({required this.label, required this.points});

  MultipleChoiceAnswer.fromJson(Map<String, dynamic> json)
      : label = Label.fromJson(json["label"]),
        points = json["points"];

  Map<String, dynamic> toJson() => {"label": label.toJson(), "points": points};
}

class MultipleChoiceQuiz extends Quiz {
  ImageData image;
  List<Label> choices;
  Map<String, MultipleChoiceAnswer> correctAnswers;
  Label? _answer;

  MultipleChoiceQuiz(
      {required super.id,
      required this.image,
      required this.choices,
      required this.correctAnswers});

  MultipleChoiceQuiz.fromJson(Map<String, dynamic> json)
      : image = ImageData.fromJson(json["image"]!),
        choices = List.from(json["choices"]!)
            .map((labelJson) => Label.fromJson(labelJson!))
            .toList(),
        correctAnswers = {
          for (var jsonAnswer in List.from(json["correct_answers"]!))
            jsonAnswer["label"]["id"]: MultipleChoiceAnswer.fromJson(jsonAnswer)
        },
        super(id: json["id"].toString());

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image.toJson(),
        "choices": choices,
        "correct_answer": correctAnswers.entries.toList(),
        "_answer": _answer!.toJson()
      };

  @override
  Label? get answer {
    return _answer;
  }

  @override
  set answer(dynamic answer) {
    if (answer == null) {
      _answer = null;
    } else {
      _answer = answer as Label;
    }
  }

  @override
  bool isAnswerSet() {
    return _answer != null;
  }

  @override
  int getPoints() {
    if (isAnswerSet()) {
      var something = correctAnswers[_answer!.id];
      if (something != null) {
        return something.points;
      }
    }
    return 0;
  }
}
