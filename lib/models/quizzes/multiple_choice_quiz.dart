import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';

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

  MultipleChoiceQuiz.fromJson(Map<String, dynamic> json)
      : id = json["id"]!.toString(),
        image = ImageData.fromJson(json["image"]!),
        choices = List.from(json["choices"]!)
            .map((labelJson) => Label.fromJson(labelJson!))
            .toList(),
        correctAnswer = Label.fromJson(json["correctAnswer"]!);

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image.toJson(),
        "choices": choices,
        "correctAnswer": correctAnswer.toJson(),
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
}
