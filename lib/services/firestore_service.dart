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

class FirestoreCollections {
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

  /// NOTE: Currently, we construct the whole Json data and then de-serialize
  /// it with fromJson constructor. There are two disadvantages: (1) hard for
  /// debugging if the fromJson constructor has trouble; (2) performance issue.

  /// NOTE: Try to use multi-threading to enhance the performance

  Future<MultipleChoiceQuiz> buildMultipleChoice(String quizId) async {
    var ref =
        _db.collection(FirestoreCollections.multipleChoiceQuizzes).doc(quizId);
    final quiz = await ref.get().then((value) => value.data());
    // log.d(quiz);

    Map<String, dynamic> quizJson = {};
    quizJson["id"] = quizId;

    ref = _db.collection(FirestoreCollections.images).doc(quiz!["image_id"]);
    final image = await ref.get().then((value) => value.data());
    quizJson["image"] = image;

    var labelQuery = _db
        .collection(FirestoreCollections.labels)
        .where("id", whereIn: quiz["choices"]);
    final labelQuerySnapshot = await labelQuery.get();
    Map<String, dynamic> choiceLabels = {};
    for (var element in labelQuerySnapshot.docs) {
      final data = element.data();
      choiceLabels[data["id"]] = data;
    }
    List<dynamic> choices = [];
    for (final choiceLabelId in quiz["choices"]) {
      choices.add(choiceLabels[choiceLabelId]);
    }
    quizJson["choices"] = choices;

    List<Map<String, dynamic>> correctAnswers = [];
    for (final ans in quiz["correct_answers"]) {
      if (choiceLabels.keys.contains(ans["label_id"])) {
        Map<String, dynamic> ansObj = {};
        ansObj["points"] = ans["points"];
        ansObj["label"] = choiceLabels[ans["label_id"]];
        correctAnswers.add(ansObj);
      }
    }
    quizJson["correct_answers"] = correctAnswers;
    // log.d(quizJson);

    return MultipleChoiceQuiz.fromJson(quizJson);
  }

  Future<InputQuiz> buildInput(String quizId) async {
    var ref = _db.collection(FirestoreCollections.inputQuizzes).doc(quizId);
    final quiz = await ref.get().then((value) => value.data());
    // log.d(quiz);

    Map<String, dynamic> quizJson = {};
    quizJson["id"] = quizId;

    ref = _db.collection(FirestoreCollections.images).doc(quiz!["image_id"]);
    final image = await ref.get().then((value) => value.data());
    quizJson["image"] = image;

    // NOTE: simplify the storage of correct_answers in the database
    List<Map<String, dynamic>> correctAnswers = [];
    List<String> correctLabelIds = [];
    for (final ans in quiz["correct_answers"]) {
      correctLabelIds.add(ans["label_id"]);
    }
    final labelQuery = _db
        .collection(FirestoreCollections.labels)
        .where("id", whereIn: correctLabelIds);
    final labelQuerySnapshot = await labelQuery.get();
    Map<String, dynamic> correctLabels = {};
    for (var element in labelQuerySnapshot.docs) {
      final data = element.data();
      correctLabels[data["id"]] = data;
    }
    for (final ans in quiz["correct_answers"]) {
      Map<String, dynamic> ansObj = {};
      ansObj["points"] = ans["points"];
      ansObj["label"] = correctLabels[ans["label_id"]];
      correctAnswers.add(ansObj);
    }
    quizJson["correct_answers"] = correctAnswers;
    // log.d(quizJson);

    return InputQuiz.fromJson(quizJson);
  }

  Future<SelectionQuiz> buildSelection(String quizId) async {
    var ref = _db.collection(FirestoreCollections.selectionQuizzes).doc(quizId);
    final quiz = await ref.get().then((value) => value.data());
    log.d(quiz);

    Map<String, dynamic> quizJson = {};
    quizJson["id"] = quizId;

    ref = _db.collection(FirestoreCollections.labels).doc(quiz!["label_id"]);
    final label = await ref.get().then((value) => value.data());
    quizJson["label"] = label;

    var imageQuery = _db
        .collection(FirestoreCollections.images)
        .where("id", whereIn: quiz["selections"]);
    final imageQuerySnapshot = await imageQuery.get();
    Map<String, dynamic> allImages = {};
    for (var element in imageQuerySnapshot.docs) {
      final data = element.data();
      allImages[data["id"]] = data;
    }
    List<dynamic> selections = [];
    for (final selectedImgId in quiz["selections"]) {
      selections.add(allImages[selectedImgId]);
    }
    quizJson["selections"] = selections;

    List<Map<String, dynamic>> correctAnswers = [];
    for (final ans in quiz["correct_answers"]) {
      Map<String, dynamic> ansObj = {};
      ansObj["points"] = ans["points"];
      ansObj["image"] = allImages[ans["image_id"]];
      correctAnswers.add(ansObj);
    }
    quizJson["correct_answers"] = correctAnswers;
    log.d(quizJson);

    return SelectionQuiz.fromJson(quizJson);
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Map<String, Future<Quiz> Function(String quizId)> _quizBuilderMap = {
    FirestoreCollections.multipleChoiceQuizzes:
        _QuizBuilders().buildMultipleChoice,
    FirestoreCollections.inputQuizzes: _QuizBuilders().buildInput,
    FirestoreCollections.selectionQuizzes: _QuizBuilders().buildSelection,
  };

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
      quizList.add(await _quizBuilderMap[quizCollection]!.call(quizId));
    }
    return quizList;
  }
}
