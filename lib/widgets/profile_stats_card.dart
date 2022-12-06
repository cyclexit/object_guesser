import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';

class ProfileStatsCard extends StatelessWidget {
  final int averagePoints;
  final int totalGames;

  const ProfileStatsCard(
      {super.key, required this.averagePoints, required this.totalGames});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            spreadRadius: -4,
            blurRadius: 25,
            offset: const Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileStat(
              text: "total\ngames",
              stat: totalGames,
              icon: FluentIcons.games_16_filled),
          ProfileStat(
              text: "average\npoints",
              stat: averagePoints,
              icon: FluentIcons.star_16_filled),
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String text;
  final num stat;
  final IconData icon;

  const ProfileStat(
      {super.key, required this.text, required this.stat, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 48.0,
        ),
        const SizedBox(width: 15.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text.toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.secondary),
              softWrap: true,
            ),
            Text(
              "$stat",
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        )
      ],
    );
  }
}
