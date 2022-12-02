// ignore_for_file: unused_element, unused_field

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';

class _Collections {
  static const String images = "images";
  static const String labels = "labels";
  static const String imageLabelRecords = "image_label_records";
  static const String multipleChoiceQuizzes = "multiple_choice_quizzes";
  static const String inputQuizzes = "input_quizzes";
  static const String selectionQuizzes = "selection_quizzes";
  static const String games = "games";
}

class _QuizBuilders {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<MultipleChoiceQuiz?> buildMultipleChoice(String quizId) async {
    return null;
  }

  Future<InputQuiz?> buildInput(String quizId) async {
    return null;
  }

  Future<SelectionQuiz?> buildSelection(String quizId) async {
    return null;
  }
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
    // NOTE: assume the user can play the same game more than once.
    final ref =
        _db.collection("games").where("category_id", isEqualTo: category.id);
    final snapshot = await ref.get();
    final games = snapshot.docs.map((e) => e.data()).toList();
    final game = games[Random().nextInt(games.length)];
    final quizzes = game["quizzes"] as List;
    if (quizzes.length < totalQuizzes) {
      log.e(
          "Not enough quizzes for this game.Need $totalQuizzes, but only has ${quizzes.length}");
      return [];
    }

    List<Quiz> quizList = [];
    for (int i = 0; i < totalQuizzes; ++i) {
      final quizId = game["quizzes"][i]["id"];
      final quizCollection = game["quizzes"][i]["collection"];
    }
    return quizList;
  }
}
