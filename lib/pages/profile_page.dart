import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = AuthService().user;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("uid: ${user!.uid}",
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.apply(color: blackColor)),
        const SizedBox(height: 10),
        Text("email: ${user.email ?? "None"}",
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.apply(color: blackColor)),
        ElevatedButton(
            onPressed: () async {
              await AuthService().signOut();
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    MainPage.routeName, (route) => false);
              }
            },
            child: const Text("Sign out")),
      ],
    ));
  }
}
