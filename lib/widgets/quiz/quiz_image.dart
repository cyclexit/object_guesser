import 'package:flutter/material.dart';
import 'package:object_guesser/models/image.dart';

class QuizImage extends StatelessWidget {
  final ImageData image;

  const QuizImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        image.url,
        height: 375,
        width: 375,
        fit: BoxFit.cover,
      ),
    );
  }
}
