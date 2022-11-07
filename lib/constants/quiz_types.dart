import 'package:object_guesser/models/quizes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizes/input_quiz.dart';
import 'package:object_guesser/models/quizes/selection_quiz.dart';
import 'package:object_guesser/models/quizes/quiz_type_info.dart';

const QuizTypeInfo multipleChoice = QuizTypeInfo(
    quizType: "Multiple Choice",
    quizTypeDescription: "Select the best answer.");

const QuizTypeInfo input = QuizTypeInfo(
    quizType: "Input",
    quizTypeDescription: "Enter the most specific label for the picture;");

const QuizTypeInfo select = QuizTypeInfo(
    quizType: "Select",
    quizTypeDescription:
        "Select the pictures which contain the object described by the label.");

const Map<Type, QuizTypeInfo> quizTypeInfoMap = {
  MultipleChoiceQuiz: multipleChoice,
  InputQuiz: input,
  SelectionQuiz: select
};
