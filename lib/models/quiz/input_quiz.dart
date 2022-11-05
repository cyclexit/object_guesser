import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quiz/quiz.dart';

class InputQuiz extends Quiz {
  String id;
  ImageData image;

  // List of possible answer for the input.
  // This can be null since an Input Quiz
  // could be an `Unlabelled` Image.
  List<Label>? correctAnswers;
  String _answer = "";

  InputQuiz({
    required this.id,
    required this.image,
    this.correctAnswers,
  });

  InputQuiz.fromJson(Map<String, dynamic> json)
      : id = json['id']!.toString(),
        image = ImageData.fromJson(json["image"]),
        correctAnswers = List.from(json["correctAnswers"]!)
            .map((labelJson) => Label.fromJson(labelJson))
            .toList();

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image.toJson(),
        "correctAnswers": correctAnswers ?? [],
        "_answer": _answer,
      };

  @override
  String get answer {
    return _answer;
  }

  @override
  set answer(dynamic answer) {
    // ignore: todo
    // TODO: validate input
    _answer = answer as String;
  }
}
