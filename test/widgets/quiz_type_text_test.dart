import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';

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
              QuizTypeText(quizTypeInfo: multipleChoice),
              SizedBox(height: 5),
              QuizTypeText(quizTypeInfo: input),
              SizedBox(height: 5),
              QuizTypeText(quizTypeInfo: select)
            ]),
      ),
    );
  }
}

Widget createTestPage() {
  return const MaterialApp(home: TestPage());
}

void main() {
  group("QuizTypeText widget tests\n", () {
    testWidgets("Find by gameMode", (tester) async {
      await tester.pumpWidget(createTestPage());
      expect(find.byType(QuizTypeText), findsNWidgets(3));
      expect(find.widgetWithText(QuizTypeText, multipleChoice.type),
          findsOneWidget);
      expect(find.widgetWithText(QuizTypeText, input.type), findsOneWidget);
      expect(find.widgetWithText(QuizTypeText, select.type), findsOneWidget);
    });

    testWidgets("Find by gameModeDescription", (tester) async {
      await tester.pumpWidget(createTestPage());
      expect(find.byTooltip(multipleChoice.description), findsOneWidget);
      expect(find.byTooltip(input.description), findsOneWidget);
      expect(find.byTooltip(select.description), findsOneWidget);
    });
  });
}
