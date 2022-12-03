import 'package:cloud_firestore/cloud_firestore.dart';

class GameRecord {
  /// Store `Timestamp` for easy Json serialization.
  /// `Timestamp` is converted to `DateTime` only for UI.

  final String gameId;
  final Timestamp timestamp;

  GameRecord({required this.gameId, required this.timestamp});

  GameRecord.fromJson(Map<String, dynamic> json)
      : gameId = json["game_id"] ?? "",
        timestamp = json["timestamp"] ?? Timestamp(0, 0);
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
}
