import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:object_guesser/models/label.dart';

/// A category is a root label in the label hierarchy.
class Category {
  static const Map<String, IconData> _categoryIconMap = {
    "car": FontAwesomeIcons.car,
    "dog": FontAwesomeIcons.dog,
    "fruit": FontAwesomeIcons.raspberryPi
  };

  final String id;
  final String name;
  final IconData icon;

  Category.fromLabel(Label label)
      : id = label.id,
        name = label.name,
        icon = _categoryIconMap[label.name] ?? Icons.question_mark;
}
