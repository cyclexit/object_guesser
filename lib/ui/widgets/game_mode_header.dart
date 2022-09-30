import 'package:flutter/material.dart';

class GameModeHeader extends StatelessWidget {
  final String gameMode;
  final String gameModeDescription;
  const GameModeHeader(
      {Key? key, required this.gameMode, required this.gameModeDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: gameModeDescription,
      child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          child: Text(
            gameMode,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
