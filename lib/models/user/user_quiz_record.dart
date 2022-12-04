import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/services/firestore_service.dart';

class UserQuizRecord {
  final String uid;
  final String quizId;
  final String quizCollection;
  final int points;
  final dynamic userAnswer;

  UserQuizRecord(
      {required this.uid,
      required this.quizId,
      required this.quizCollection,
      required this.points,
      required this.userAnswer});

  UserQuizRecord.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        quizId = json["quiz_id"],
        quizCollection = json["quiz_collection"],
        points = json["points"],
        userAnswer = {
          if (json["quiz_collection"] ==
              FirestoreCollections.multipleChoiceQuizzes)
            Label.fromJson(json["user_answer"])
          else if (json["quiz_collection"] == FirestoreCollections.inputQuizzes)
            json["user_answer"] as String
          else if (json["quiz_collection"] ==
              FirestoreCollections.selectionQuizzes)
            List.from(json["user_answer"]!)
                .map((img) => ImageData.fromJson(img))
                .toList()
          else
            "Error: unkown quiz type"
        };

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "quiz_id": quizId,
        "quiz_collection": quizCollection,
        "points": points,
        "user_answer": {
          if (quizCollection == FirestoreCollections.multipleChoiceQuizzes)
            (userAnswer as Label).toJson()
          else if (quizCollection == FirestoreCollections.inputQuizzes)
            userAnswer as String
          else if (quizCollection == FirestoreCollections.selectionQuizzes)
            (userAnswer as List<ImageData>).map((img) => img.toJson()).toList()
          else
            "Error: unkown quiz type"
        }
      };
}
