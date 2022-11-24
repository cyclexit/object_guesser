import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:object_guesser/models/label.dart';

void main() {
  File jsonFile = File('./test/models/data/label.json');
  dynamic jsonData = jsonDecode(jsonFile.readAsStringSync());
  test("Label class JSON serialization", () {
    Label label = Label.fromJson(jsonData);
    Map<String, dynamic> toJson = label.toJson();
    toJson.forEach((key, value) {
      assert(jsonData[key] == value);
    });
  });
}
