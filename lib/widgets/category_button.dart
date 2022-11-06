import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/category.dart';

class CategoryButton extends StatelessWidget {
  final Category category;

  const CategoryButton({super.key, required this.category});

  // ignore: todo
  // TODO: on press function, route to quiz screen
  void handlePress() {}

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ElevatedButton(
        onPressed: handlePress,
        style: ElevatedButton.styleFrom(
          foregroundColor: blackColor,
          padding: const EdgeInsets.all(10.0),
          backgroundColor: whiteColor,
          elevation: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              category.icon,
              size: 38.0,
              color: theme.colorScheme.secondary,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              category.name,
              style: theme.textTheme.bodyText1,
            )
          ],
        ));
  }
}
