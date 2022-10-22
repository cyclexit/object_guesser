import 'package:flutter/material.dart';
import 'package:object_guesser/models/game_mode_info.dart';
import 'package:object_guesser/config/themes.dart';

class GameModeHeader extends StatelessWidget {
  final GameModeInfo gameModeInfo;
  const GameModeHeader({super.key, required this.gameModeInfo});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Tooltip(
      message: gameModeInfo.gameModeDescription,
      triggerMode: TooltipTriggerMode.tap,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: blackColor, borderRadius: BorderRadius.circular(2.0)),
          constraints: const BoxConstraints(minWidth: 200.0),
          child: Text(
            gameModeInfo.gameMode,
            style: theme.textTheme.subtitle1?.apply(color: whiteColor),
            textAlign: TextAlign.center,
          )),
    );
  }
}
