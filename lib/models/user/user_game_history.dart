import 'package:cloud_firestore/cloud_firestore.dart';

class GameRecord {
  /// Store `Timestamp` for easy Json serialization.
  /// `Timestamp` is converted to `DateTime` only for UI.

  final String gameId;
  final Timestamp timestamp;

  GameRecord({required this.gameId, required this.timestamp});

  /// `Timestamp` is Firestore specific type. This conversion works with
  /// Firestore API calls, but cannot be normally converted from JSON text or
  /// to JSON text. Hence, no unit test can be created for this class.
  GameRecord.fromJson(Map<String, dynamic> json)
      : gameId = json["game_id"] ?? "",
        timestamp = json["timestamp"] as Timestamp;

  /// WARNING: Because `Timestamp` does not have toJson function implemented,
  /// this toJson CANNOT be used when the app try to upload the data to the
  /// database! This function is just for debug purpose.
  Map<String, dynamic> toJson() =>
      {"game_id": gameId, "timestamp": timestamp.toString()};
}

class UserGameHistory {
  String uid;
  List<GameRecord> gameRecords;

  UserGameHistory({this.uid = "", this.gameRecords = const []});

  UserGameHistory.fromJson(Map<String, dynamic> json)
      : uid = json["uid"] ?? "",
        gameRecords = json["game_records"] != null
            ? List.from(json["game_records"])
                .map((recordJson) => GameRecord.fromJson(recordJson))
                .toList()
            : [];

  Map<String, dynamic> toJson() =>
      {"uid": uid, "game_records": gameRecords.map((e) => e.toJson()).toList()};
}
