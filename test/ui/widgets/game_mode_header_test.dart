import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:object_guesser/game/game_modes.dart';
import 'package:object_guesser/ui/widgets/game_mode_header.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              GameModeHeader(gameModeInfo: multipleChoice),
              GameModeHeader(gameModeInfo: input),
              GameModeHeader(gameModeInfo: select)
            ]),
      ),
    );
  }
}

Widget createTestPage() {
  return const MaterialApp(home: TestPage());
}

void main() {
  group("GameModeHeader widget tests\n", () {
    testWidgets("Test if 3 GameModeHeader objects show up", (tester) async {
      await tester.pumpWidget(createTestPage());
      expect(find.byType(GameModeHeader), findsNWidgets(3));
    });
  });
}
