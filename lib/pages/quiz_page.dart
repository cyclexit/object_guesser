import 'package:flutter/material.dart';

import 'package:object_guesser/log.dart';
import 'package:object_guesser/constants/quiz_types.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/models/quizes/input_quiz.dart';
import 'package:object_guesser/models/quizes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizes/quiz.dart';
import 'package:object_guesser/services/get_image.dart';
import 'package:object_guesser/services/get_quizes.dart';
import 'package:object_guesser/widgets/buttons/next_button.dart';
import 'package:object_guesser/widgets/quiz_type_text.dart';
import 'package:object_guesser/widgets/choice_list.dart';
import 'package:object_guesser/widgets/quiz_container.dart';
import 'package:object_guesser/widgets/user_input_form.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const int _totalQuizes = 2;
  List<Quiz> _quizes = [];
  bool _isDataReady = false;
  late int _idx;

  void setAnswer(Label? choice) {}
  void submitAnswer() {}

  void handleNextQuiz() {
    setState(() {
      ++_idx;
    });
  }

  Widget _updateImageArea() {
    Type quizType = _quizes[_idx].runtimeType;
    if (quizType == MultipleChoiceQuiz) {
      MultipleChoiceQuiz quiz = _quizes[_idx] as MultipleChoiceQuiz;
      return getImage(quiz.image.url);
    } else if (quizType == InputQuiz) {
      InputQuiz quiz = _quizes[_idx] as InputQuiz;
      return getImage(quiz.image.url);
    }
    return const SizedBox(height: 0);
  }

  Widget _updateUserAnswerArea() {
    Type quizType = _quizes[_idx].runtimeType;
    if (quizType == MultipleChoiceQuiz) {
      MultipleChoiceQuiz quiz = _quizes[_idx] as MultipleChoiceQuiz;
      return ChoiceList(setAnswer: setAnswer, choices: quiz.choices);
    } else if (quizType == InputQuiz) {
      return const UserInputForm();
    }
    return const SizedBox(height: 0);
  }

  @override
  void initState() {
    super.initState();
    Future<List<Quiz>> future = getQuizes(_totalQuizes);
    future.then((value) {
      _quizes = value;
      setState(() {
        _idx = 0;
        _isDataReady = true;
      });
    }, onError: (error) {
      log.e(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDataReady) {
      return Scaffold(
          appBar: AppBar(),
          body: const Center(
              child: Text(
            "Loading....",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          )));
    } else if (_idx < _totalQuizes) {
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: QuizContainer(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _updateImageArea(),
                    const SizedBox(height: 20),
                    QuizTypeText(
                        quizTypeInfo:
                            quizTypeInfoMap[_quizes[_idx].runtimeType]!),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _updateUserAnswerArea(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    NextButton(handlePress: handleNextQuiz),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ]),
            ),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(),
          body: const Center(
              child: Text(
            "Finish the quiz!!!",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          )));
    }
  }
}
