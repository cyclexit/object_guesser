import 'package:flutter/material.dart';
import 'package:object_guesser/models/user/user_game_history.dart';
import 'package:object_guesser/widgets/profile_stats_card.dart';
import 'package:provider/provider.dart';

class GameHistoryPage extends StatelessWidget {
  const GameHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserGameHistory userGameHistory =
        Provider.of<UserGameHistory>(context);

    var totalGames = userGameHistory.gameRecords.length;
    var averagePoints = 0;

    if (totalGames != 0) {
      averagePoints = (userGameHistory.totalPoints / totalGames).round();
    }

    return SafeArea(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Stats",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 12.0),
                ProfileStatsCard(
                    averagePoints: averagePoints, totalGames: totalGames),
              ],
            )));
  }
}
