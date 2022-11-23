import 'package:flutter/material.dart';

/// A category is a root label in the label hierarchy.
class Category {
  final String id;
  final String name;
  final IconData icon;

  const Category(
      {required this.id, required this.name, this.icon = Icons.question_mark});
}
