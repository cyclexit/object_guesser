import 'package:flutter/material.dart';
import 'package:object_guesser/models/image.dart';

class QuizImage extends StatelessWidget {
  final ImageData image;
  final double height;
  final double width;

  const QuizImage(
      {super.key,
      required this.image,
      this.height = 275.0,
      this.width = 275.0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        image.url,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
