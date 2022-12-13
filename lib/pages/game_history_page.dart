import 'package:flutter/material.dart';
import 'package:object_guesser/models/user/user_game_history.dart';
import 'package:object_guesser/widgets/game_record_card.dart';
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
                const SizedBox(height: 16.0),
                Text(
                  "Rank: ${userGameHistory.rank > 0 ? userGameHistory.rank : "None"}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 16.0),
                Text(
                  "History",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 12.0),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: GameRecordCard(
                              record: userGameHistory.gameRecords[index]),
                        )),
                    itemCount: userGameHistory.gameRecords.length,
                  ),
                )
              ],
            )));
  }
}
