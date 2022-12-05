import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:object_guesser/models/user/user_game_history.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/services/auth.dart';
import 'package:object_guesser/widgets/profile_info_card.dart';

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
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileInfoCard(user: user!),
          const Spacer(),
          Text("Total games: ${userGameHistory.gameRecords.length}"),
          const Spacer(),
          Text("Total points: ${userGameHistory.totalPoints}"),
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
