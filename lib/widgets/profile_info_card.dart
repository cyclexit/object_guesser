import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';

class ProfileInfoCard extends StatelessWidget {
  final User user;

  const ProfileInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 25,
            offset: const Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Row(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
                width: 100.0,
                height: 100.0,
                color: Theme.of(context).colorScheme.secondary,
                child: user.photoURL != null
                    ? Image.network(
                        user.photoURL!,
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Icon(
                          FluentIcons.person_12_filled,
                          color: whiteColor,
                          size: 64.0,
                        ),
                      ))),
        const SizedBox(
          width: 16.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.displayName ?? "Anonymous",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            if (user.email != null)
              Text(
                user.email!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.apply(color: blackColor),
              )
          ],
        ),
      ]),
    );
  }
}
