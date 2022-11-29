import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:object_guesser/config/themes.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 48.0, bottom: 20.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
      child: Column(children: [
        const Icon(
          FluentIcons.box_search_20_filled,
          color: whiteColor,
          size: 100.0,
        ),
        Text("ObjectGuesser", style: Theme.of(context).textTheme.headline1),
      ]),
    );
  }
}
