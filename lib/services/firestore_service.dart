// ignore_for_file: unused_element, unused_field

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';
import 'package:object_guesser/models/user/user_game_history.dart';
import 'package:object_guesser/models/user/user_quiz_record.dart';
import 'package:object_guesser/services/auth.dart';

class FirestoreCollections {
  static const String images = "images";
  static const String labels = "labels";
  static const String imageLabelRecords = "image_label_records";
  static const String multipleChoiceQuizzes = "multiple_choice_quizzes";
  static const String inputQuizzes = "input_quizzes";
  static const String selectionQuizzes = "selection_quizzes";
  static const String games = "games";
  static const String userQuizRecords = "user_quiz_records";
  static const String userGameHistory = "user_game_history";
}

const Map<Type, String> _quizTypeToCollection = {
  MultipleChoiceQuiz: FirestoreCollections.multipleChoiceQuizzes,
  InputQuiz: FirestoreCollections.inputQuizzes,
  SelectionQuiz: FirestoreCollections.selectionQuizzes
};

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
    quizJson["max_points"] = quiz!["max_points"];

    ref = _db.collection(FirestoreCollections.images).doc(quiz["image_id"]);
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
    // log.d(quiz);

    Map<String, dynamic> quizJson = {};
    quizJson["id"] = quizId;
    quizJson["max_points"] = quiz!["max_points"];

    ref = _db.collection(FirestoreCollections.labels).doc(quiz["label_id"]);
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
    // log.d(quizJson);

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

  Future<Map<String, dynamic>> getQuizzes(
      int totalQuizzes, Category category) async {
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
      return {};
    }

    List<Quiz> quizList = [];
    for (int i = 0; i < totalQuizzes; ++i) {
      final quizId = game["quizzes"][i]["id"];
      final quizCollection = game["quizzes"][i]["collection"];
      quizList.add(await _quizBuilderMap[quizCollection]!.call(quizId));
    }
    return {"game_id": game["id"] as String, "quizzes": quizList};
  }

  Future<void> uploadUserQuizRecord(String quizId, Type quizType, int points,
      dynamic answer, Timestamp finishTime) async {
    UserQuizRecord userQuizRecord = UserQuizRecord(
        uid: AuthService().user!.uid,
        quizId: quizId,
        quizCollection: _quizTypeToCollection[quizType]!,
        points: points,
        timestamp: finishTime);
    switch (quizType) {
      case MultipleChoiceQuiz:
        userQuizRecord.multipleChoiceAnswer = answer;
        break;
      case InputQuiz:
        userQuizRecord.inputAnswer = answer;
        break;
      case SelectionQuiz:
        userQuizRecord.selectionAnswer = answer;
        break;
      default:
        log.e("Unkown quiz type!");
        break;
    }
    final ref = _db.collection(FirestoreCollections.userQuizRecords).doc();
    return ref.set(userQuizRecord.toJson(), SetOptions(merge: true));
  }

  Stream<UserGameHistory> streamUserGameHistory() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        final ref =
            _db.collection(FirestoreCollections.userGameHistory).doc(user.uid);
        return ref
            .snapshots()
            .map((event) => UserGameHistory.fromJson(event.data()!));
      } else {
        log.e("User is null!");
        return Stream.fromIterable([UserGameHistory()]);
      }
    });
  }

  Future<void> updateUserGameHistory(
      String gameId, int gamePoints, Timestamp finishTime) async {
    final user = AuthService().user;
    final ref =
        _db.collection(FirestoreCollections.userGameHistory).doc(user!.uid);
    if (!(await ref.get()).exists) {
      ref.set(UserGameHistory(uid: user.uid).toJson(), SetOptions(merge: true));
    }
    return ref.update({
      "total_points": FieldValue.increment(gamePoints),
      "game_records": FieldValue.arrayUnion([
        GameRecord(
                gameId: gameId, gamePoints: gamePoints, timestamp: finishTime)
            .toJson()
      ])
    });
  }

  /// If we find the corresponding label based on the user input, return the
  /// existing `label_id`.
  ///
  /// Otherwise, add a new label in the collection and return the `label_id` of
  /// the newly created label.
  Future<String> _getLabelId(String userInput) async {
    String potentialLabelName = userInput.replaceAll(" ", "_");
    final query = _db
        .collection(FirestoreCollections.labels)
        .where("name", isEqualTo: potentialLabelName);
    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      // create a new label
      Map<String, dynamic> labelJson = {
        "from_wordnet": false,
        "name": potentialLabelName,
      };
      final ref = _db.collection(FirestoreCollections.labels).doc();
      labelJson["id"] = ref.id;
      labelJson["parent_id"] = ref.id;
      labelJson["root_id"] = ref.id;
      await ref.set(labelJson, SetOptions(merge: true));
      return ref.id;
    }
    final label = snapshot.docs.first.data();
    return label["id"];
  }

  Future<void> _updateImageLabelRecords(
      final String labelId, final String imageId, double w) async {
    final query = _db
        .collection(FirestoreCollections.imageLabelRecords)
        .where("label_id", isEqualTo: labelId)
        .where("image_id", isEqualTo: imageId);
    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      // create a new record
      Map<String, dynamic> recordJson = {
        "label_id": labelId,
        "image_id": imageId,
        "weight": w
      };
      final ref = _db.collection(FirestoreCollections.imageLabelRecords).doc();
      recordJson["id"] = ref.id;
      ref.set(recordJson, SetOptions(merge: true));
    } else {
      final record = snapshot.docs.first.data();
      final ref = _db
          .collection(FirestoreCollections.imageLabelRecords)
          .doc(record["id"]);
      ref.update({"weight": FieldValue.increment(w)});
    }
  }

  Future<UserGameHistory> _getUserGameHistory() async {
    final ref = _db
        .collection(FirestoreCollections.userGameHistory)
        .doc(AuthService().user!.uid);
    final json = await ref.get().then((value) => value.data());
    return UserGameHistory.fromJson(json!);
  }

  /// Update the `ImageLabelRecords` with the user answers of `InputQuiz`.
  /// The weight is calculated by (user average points / 1000).
  Future<void> updateImageLabelRecords(final List<Quiz> quizzes) async {
    // 1. user weight calculation
    // 2. check the user input: transform the wordnet label name and compare with the user answer
    // 3. find the correct image label record if exists; or create a new image label record
    // 4. update the records
    const double userContributionRatio = 1 / 1000;
    final UserGameHistory userGameHistory = await _getUserGameHistory();

    for (final quiz in quizzes) {
      if (quiz.runtimeType == InputQuiz) {
        final q = quiz as InputQuiz;
        if (q.answer.isNotEmpty) {
          final String labelId = await _getLabelId(q.answer);
          final double w = userGameHistory.totalPoints /
              userGameHistory.gameRecords.length *
              userContributionRatio;
          _updateImageLabelRecords(labelId, q.image.id, w);
        }
      }
    }
  }
}
