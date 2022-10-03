import 'package:flutter_test/flutter_test.dart';

import 'package:object_guesser/game/user_input_regex.dart';

void main() {
  group("Test regex for trimmed user input:", () {
    test("Valid Input", () {
      // empty string
      assert(trimmedUserInputRegExp.hasMatch(""));

      // trimmed empty string
      assert(trimmedUserInputRegExp.hasMatch("     ".trim()));

      // single word
      assert(trimmedUserInputRegExp.hasMatch("dog"));

      // single word with hyphen
      assert(trimmedUserInputRegExp.hasMatch("mother-in-law"));

      // phrase
      assert(trimmedUserInputRegExp
          .hasMatch("golden retriever")); // separated by white space
      assert(trimmedUserInputRegExp
          .hasMatch("golden-retriever")); // separated by hyphen
    });
    test("Invalid Input", () {
      // untrimmed string
      assert(!trimmedUserInputRegExp.hasMatch("       "));
      assert(!trimmedUserInputRegExp.hasMatch("  cat  "));

      // not begin with a latin letter
      assert(!trimmedUserInputRegExp.hasMatch("-dog"));
      assert(!trimmedUserInputRegExp.hasMatch("_dog"));

      // phrase separated by underscore
      assert(!trimmedUserInputRegExp.hasMatch("golden_retriever"));

      // phrase separated by two or more spaces
      assert(!trimmedUserInputRegExp.hasMatch("golden  retriever"));
      assert(!trimmedUserInputRegExp.hasMatch("golden   retriever"));

      // end with a non-latin letter
      assert(!trimmedUserInputRegExp.hasMatch("dog-"));
      assert(!trimmedUserInputRegExp.hasMatch("       dog-"));
      assert(!trimmedUserInputRegExp.hasMatch("dog-       "));
      assert(!trimmedUserInputRegExp.hasMatch("dog_!@#"));

      // random invalid characters
      assert(
          !trimmedUserInputRegExp.hasMatch("!@#\$%^&*()_+[]{}\\|;:,./<>?'\""));
    });
  });
}
