import 'package:object_guesser/models/quiz_type_info.dart';

const QuizTypeInfo multipleChoice = QuizTypeInfo(
    gameMode: "Multiple Choice",
    gameModeDescription: "Select the best answer.");

const QuizTypeInfo input = QuizTypeInfo(
    gameMode: "Input",
    gameModeDescription: "Enter the most specific label for the picture;");

const QuizTypeInfo select = QuizTypeInfo(
    gameMode: "Select",
    gameModeDescription:
        "Select the pictures which contain the object described by the label.");
