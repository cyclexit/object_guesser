import 'package:flutter/material.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/widgets/game_mode_header.dart';

// The about page is used for temporary UI components visualization during the
// development.
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
