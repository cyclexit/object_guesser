import 'package:flutter/material.dart';
import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/widgets/quiz/quiz_image.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/user_input_form.dart';

class InputArea extends StatelessWidget {
  final InputQuiz quiz;

  const InputArea({super.key, required this.quiz});

  void setAnswer(String? userInput) {
    quiz.answer = userInput;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 15.0,
      ),
      const QuizTypeText(quizTypeInfo: input),
      const SizedBox(
        height: 30.0,
      ),
      QuizImage(image: quiz.image),
      const SizedBox(
        height: 15.0,
      ),
      // Hongyi: Bandaid for now to make the input quiz look similar to multiple
      //         choice quiz
      const Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: UserInputForm(),
      ),
    ]);
  }
}
