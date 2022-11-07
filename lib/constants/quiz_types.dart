import 'package:object_guesser/models/quizzes/multiple_choice_quiz.dart';
import 'package:object_guesser/models/quizzes/input_quiz.dart';
import 'package:object_guesser/models/quizzes/selection_quiz.dart';
import 'package:object_guesser/models/quizzes/quiz_type_info.dart';

const QuizTypeInfo multipleChoice = QuizTypeInfo(
    type: "Multiple Choice", description: "Select the best answer.");

const QuizTypeInfo input = QuizTypeInfo(
    type: "Input",
    description: "Enter the most specific label for the picture;");

const QuizTypeInfo select = QuizTypeInfo(
    type: "Select",
    description:
        "Select the pictures which contain the object described by the label.");

const Map<Type, QuizTypeInfo> quizTypeInfoMap = {
  MultipleChoiceQuiz: multipleChoice,
  InputQuiz: input,
  SelectionQuiz: select
};
