import 'package:flutter/material.dart';
import 'package:object_guesser/models/game_mode_info.dart';

class GameModeHeader extends StatelessWidget {
  final GameModeInfo gameModeInfo;
  const GameModeHeader({Key? key, required this.gameModeInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: gameModeInfo.gameModeDescription,
      triggerMode: TooltipTriggerMode.tap,
      child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Text(
            gameModeInfo.gameMode,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
