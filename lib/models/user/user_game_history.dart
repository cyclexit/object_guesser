import 'package:cloud_firestore/cloud_firestore.dart';

class GameRecord {
  /// Store `Timestamp` for easy Json serialization. `Timestamp` is converted to
  /// `DateTime` only for UI.

  /// `Timestamp` is Firestore specific type. This conversion works with
  /// Firestore API calls, but cannot be normally converted from JSON text or
  /// to JSON text. Hence, no unit test can be created for this class.

  final String gameId;
  final int gamePoints;
  final Timestamp timestamp;

  GameRecord(
      {required this.gameId,
      required this.gamePoints,
      required this.timestamp});

  GameRecord.fromJson(Map<String, dynamic> json)
      : gameId = json["game_id"] ?? "",
        gamePoints = json["game_points"],
        timestamp = json["timestamp"] as Timestamp;

  Map<String, dynamic> toJson() =>
      {"game_id": gameId, "game_points": gamePoints, "timestamp": timestamp};
}

class UserGameHistory {
  String uid;
  int totalPoints;
  List<GameRecord> gameRecords;

  UserGameHistory(
      {this.uid = "", this.totalPoints = 0, this.gameRecords = const []});

  UserGameHistory.fromJson(Map<String, dynamic> json)
      : uid = json["uid"] ?? "",
        totalPoints = json["total_points"] as int,
        gameRecords = json["game_records"] != null
            ? List.from(json["game_records"])
                .map((recordJson) => GameRecord.fromJson(recordJson))
                .toList()
            : [];

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "total_points": totalPoints,
        "game_records": gameRecords.map((e) => e.toJson()).toList()
      };
}
