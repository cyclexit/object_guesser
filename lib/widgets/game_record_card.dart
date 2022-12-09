import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/user/user_game_history.dart';

class GameRecordCard extends StatelessWidget {
  static final DateFormat dateFormat = DateFormat("MMMM dd, yyyy");
  final GameRecord record;

  const GameRecordCard({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Icon(
                Category.categoryIconMap[record.category] ??
                    Icons.question_mark,
                color: whiteColor,
                size: 36.0),
          ),
          const SizedBox(width: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record.category,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text("+${record.gamePoints}",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
              Text(
                dateFormat.format(record.timestamp.toDate()),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: blackColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
