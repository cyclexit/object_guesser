import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';

class CategoryText extends StatelessWidget {
  final String category;
  const CategoryText({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: blackColor, borderRadius: BorderRadius.circular(2.0)),
      constraints: const BoxConstraints(minWidth: 200.0),
      child: Text(
        category,
        style: theme.textTheme.subtitle1?.apply(color: whiteColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
