import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';

class _Collections {
  static const String images = "images";
  static const String labels = "labels";
  static const String imageLabelRecords = "image_label_records";
  static const String multipleChoiceQuizzes = "multiple_choice_quizzes";
  static const String inputQuizzes = "input_quizzes";
  static const String selectionQuizzes = "selection_quizzes";
  static const String games = "games";
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// A category is a label with `root_id` and `parent_id` equal to the its own
  /// `id`.
  Future<List<Label>> getCategories() async {
    final ref = _db.collection('labels');
    final snapshot = await ref.get();
    final labels = snapshot.docs.map((e) => e.data());
    List<Label> categories = [];
    for (final label in labels) {
      if (label["id"] == label["root_id"]) {
        categories.add(Label.fromJson(label));
      }
    }
    return categories;
  }

  Future<List<Quiz>> getQuizzes(int totalQuizzes, Category category) async {
    // TODO: implement this
    return [];
  }
}
