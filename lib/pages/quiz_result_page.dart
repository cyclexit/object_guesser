import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/provider/quiz_provider.dart';
import 'package:object_guesser/widgets/quiz_result_card.dart';
import 'package:provider/provider.dart';

class QuizResultPage extends StatelessWidget {
  static const routeName = '/quiz/result';
  final Category category;

  const QuizResultPage({super.key, required this.category});

  int calculateScore(List<Quiz> quizzes) {
    int score = 0;

    for (var quiz in quizzes) {
      score += quiz.getPoints();
    }
    return score;
  }

  void exitQuiz(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(MainPage.routeName));
  }

  @override
  Widget build(BuildContext context) {
    final quizzes = Provider.of<QuizProvider>(context).quizzes;
    final score = calculateScore(quizzes);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              category.name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.apply(color: whiteColor),
            ),
            Text(
              "$score pts",
              style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: 48.0,
                  color: Theme.of(context).colorScheme.tertiary),
            ),
            const SizedBox(height: 15.0),
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: const Alignment(0.0, 0.85),
                    colors: [primaryColor, Colors.transparent],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstOut,
                child: ListView.builder(
                  itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: QuizResultCard(
                        quiz: quizzes[index],
                        categoryName: category.name,
                      ))),
                  itemCount: quizzes.length,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: () => exitQuiz(context),
                child: const Text("go back home"))
          ],
        ),
      )),
    );
  }
}
