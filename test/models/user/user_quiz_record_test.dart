import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:object_guesser/models/user/user_quiz_record.dart';

void main() {
  File jsonFile = File('./test/models/data/user_quiz_record.json');
  dynamic jsonData = jsonDecode(jsonFile.readAsStringSync());
  test("UserQuizRecord class JSON serialization", () {
    for (final rec in jsonData["records"]) {
      UserQuizRecord userQuizRecord = UserQuizRecord.fromJson(rec);
      Map<String, dynamic> toJson = userQuizRecord.toJson();
      toJson.forEach((key, value) {
        assert(rec[key].toString() == value.toString());
      });
    }
  });
}
