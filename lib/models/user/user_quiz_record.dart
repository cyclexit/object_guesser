import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/services/firestore_service.dart';

class UserQuizRecord {
  final String uid;
  final String quizId;
  final String quizCollection;
  final int points;
  final Timestamp timestamp;

  /// This is not a good way to handle the situation...
  Label? multipleChoiceAnswer;
  String? inputAnswer;
  List<ImageData>? selectionAnswer;

  UserQuizRecord(
      {required this.uid,
      required this.quizId,
      required this.quizCollection,
      required this.points,
      required this.timestamp});

  UserQuizRecord.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        quizId = json["quiz_id"],
        quizCollection = json["quiz_collection"],
        points = json["points"],
        timestamp = json["timestamp"] as Timestamp {
    if (quizCollection == FirestoreCollections.multipleChoiceQuizzes) {
      multipleChoiceAnswer = Label.fromJson(json["user_answer"]);
    } else if (quizCollection == FirestoreCollections.inputQuizzes) {
      inputAnswer = json["user_answer"] as String;
    } else if (quizCollection == FirestoreCollections.selectionQuizzes) {
      selectionAnswer = List.from(json["user_answer"]!)
          .map((img) => ImageData.fromJson(img))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json["uid"] = uid;
    json["quiz_id"] = quizId;
    json["quiz_collection"] = quizCollection;
    json["points"] = points;
    json["timestamp"] = timestamp;
    if (quizCollection == FirestoreCollections.multipleChoiceQuizzes) {
      json["user_answer"] = multipleChoiceAnswer!.toJson();
    } else if (quizCollection == FirestoreCollections.inputQuizzes) {
      json["user_answer"] = inputAnswer!;
    } else if (quizCollection == FirestoreCollections.selectionQuizzes) {
      json["user_answer"] =
          selectionAnswer!.map((img) => img.toJson()).toList();
    } else {
      json["user_answer"] = null;
    }
    return json;
  }
}
