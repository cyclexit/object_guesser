import 'package:flutter/material.dart';

import 'package:object_guesser/game/game_modes.dart';
import 'package:object_guesser/ui/widgets/game_mode_header.dart';

/*
 * hl: the about page is used for the ui debugging during the development.
 */
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: const [
            GameModeHeader(gameModeInfo: multipleChoice),
            GameModeHeader(gameModeInfo: input),
            GameModeHeader(gameModeInfo: select),
          ],
        ),
      ),
    );
  }
}
