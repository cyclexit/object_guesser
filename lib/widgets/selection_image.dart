import 'package:flutter/material.dart';
import 'package:object_guesser/models/image.dart';

class SelectionImage extends StatelessWidget {
  final ImageData image;
  final VoidCallback onPress;
  final bool isSelected;

  const SelectionImage({
    super.key,
    this.isSelected = false,
    required this.image,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(image.url),
            fit: BoxFit.cover,
            colorFilter: isSelected
                ? ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                    BlendMode.color)
                : null,
          ),
        ),
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          onTap: onPress,
        ),
      ),
    );
  }
}
