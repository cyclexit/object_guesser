import 'package:flutter/material.dart';
import 'package:object_guesser/config/themes.dart';
import 'package:object_guesser/log.dart';
import 'package:object_guesser/models/image.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/quiz.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';
import 'package:object_guesser/widgets/quiz_image.dart';

class QuizResultCard extends StatelessWidget {
  final Quiz quiz;
  final String categoryName;

  const QuizResultCard(
      {super.key, required this.quiz, this.categoryName = "category"});

  ImageData getQuizImage() {
    final type = quiz.runtimeType;
    switch (type) {
      case MultipleChoiceQuiz:
        return (quiz as MultipleChoiceQuiz).image;
      case InputQuiz:
        return (quiz as InputQuiz).image;
      case SelectionQuiz:
        return (quiz as SelectionQuiz).correctAnswers.values.first.image;
      default:
        log.e("Unknown quiz type!");
        return ImageData(id: "", url: "");
    }
  }

  String getQuizLabel() {
    final type = quiz.runtimeType;
    switch (type) {
      case MultipleChoiceQuiz:
        return getMultipleChoiceLabel(quiz as MultipleChoiceQuiz);
      case InputQuiz:
        return getInputLabel(quiz as InputQuiz);
      case SelectionQuiz:
        return (quiz as SelectionQuiz).label.name;
      default:
        log.e("Unknown quiz type!");
        return "";
    }
  }

  String getMultipleChoiceLabel(MultipleChoiceQuiz quiz) {
    var answers = quiz.correctAnswers.values.toList();
    var answerMaxPoint = answers[0];

    for (var i = 1; i < answers.length; i++) {
      var currentChoice = answers[i];
      if (currentChoice.points > answerMaxPoint.points) {
        answerMaxPoint = currentChoice;
      }
    }
    return answerMaxPoint.label.name;
  }

  String getInputLabel(InputQuiz quiz) {
    if (quiz.correctAnswers == null) {
      return categoryName;
    }

    var answers = quiz.correctAnswers!;
    var answerMaxPoint = answers[0];

    for (var i = 1; i < answers.length; i++) {
      var currentChoice = answers[i];
      if (currentChoice.points > answerMaxPoint.points) {
        answerMaxPoint = currentChoice;
      }
    }
    return answerMaxPoint.label.name;
  }

  String getQuizType() {
    final type = quiz.runtimeType;
    switch (type) {
      case MultipleChoiceQuiz:
        return "multiple choice";
      case InputQuiz:
        return "input";
      case SelectionQuiz:
        return "selection";
      default:
        log.e("Unknown quiz type!");
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          QuizImage(image: getQuizImage(), height: 50.0, width: 50.0),
          const SizedBox(width: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getQuizLabel(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                getQuizType(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: blackColor),
              ),
            ],
          ),
          const Spacer(),
          Text("+${quiz.getPoints()} pts",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}
