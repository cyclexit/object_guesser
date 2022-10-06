import 'package:object_guesser/models/game_mode_info.dart';

const GameModeInfo multipleChoice = GameModeInfo(
    gameMode: "Multiple Choice",
    gameModeDescription: "Select the best answer.");

const GameModeInfo input = GameModeInfo(
    gameMode: "Input",
    gameModeDescription: "Enter the most specific label for the picture;");

const GameModeInfo select = GameModeInfo(
    gameMode: "Select",
    gameModeDescription:
        "Select the pictures which contain the object described by the label.");
