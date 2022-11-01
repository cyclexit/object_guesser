import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/widgets/game_mode_header.dart';

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
              SizedBox(height: 5),
              GameModeHeader(gameModeInfo: input),
              SizedBox(height: 5),
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
    testWidgets("Find by gameMode", (tester) async {
      await tester.pumpWidget(createTestPage());
      expect(find.byType(GameModeHeader), findsNWidgets(3));
      expect(find.widgetWithText(GameModeHeader, multipleChoice.quizType),
          findsOneWidget);
      expect(
          find.widgetWithText(GameModeHeader, input.quizType), findsOneWidget);
      expect(
          find.widgetWithText(GameModeHeader, select.quizType), findsOneWidget);
    });

    testWidgets("Find by gameModeDescription", (tester) async {
      await tester.pumpWidget(createTestPage());
      expect(
          find.byTooltip(multipleChoice.quizTypeDescription), findsOneWidget);
      expect(find.byTooltip(input.quizTypeDescription), findsOneWidget);
      expect(find.byTooltip(select.quizTypeDescription), findsOneWidget);
    });
  });
}
