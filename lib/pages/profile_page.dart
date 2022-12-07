import 'package:flutter/material.dart';
import 'package:object_guesser/models/user/user_game_history.dart';

import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/services/auth.dart';
import 'package:object_guesser/widgets/profile_info_card.dart';
import 'package:object_guesser/widgets/profile_stats_card.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _signOut() async {
    await AuthService().signOut();
    if (mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainPage.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user;
    final UserGameHistory userGameHistory =
        Provider.of<UserGameHistory>(context);

    var totalGames = userGameHistory.gameRecords.length;
    var averagePoints = 0;

    if (totalGames != 0) {
      averagePoints = (userGameHistory.totalPoints / totalGames).round();
    }

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Your Profile",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 12.0),
          ProfileInfoCard(user: user!),
          const SizedBox(height: 30.0),
          Text(
            "Stats",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 12.0),
          ProfileStatsCard(
              averagePoints: averagePoints, totalGames: totalGames),
          const Spacer(),
          ElevatedButton(
              onPressed: _signOut,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              child: const Text("Sign out")),
        ],
      ),
    ));
  }
}
