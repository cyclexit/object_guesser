import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'profile page',
      style: Theme.of(context).textTheme.headline1?.apply(color: blackColor),
    ));
  }
}
