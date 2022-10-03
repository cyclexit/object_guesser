import 'package:flutter_test/flutter_test.dart';

import 'package:object_guesser/game/user_input_regex.dart';

void main() {
  group("Test regex for user input:", () {
    test("Valid Input", () {
      // empty string
      assert(userInputRegExp.hasMatch(""));

      // single word
      assert(userInputRegExp.hasMatch("dog"));

      // single word with hyphen
      assert(userInputRegExp.hasMatch("mother-in-law"));

      // phrase
      assert(userInputRegExp
          .hasMatch("golden retriever")); // separated by white space
      assert(
          userInputRegExp.hasMatch("golden-retriever")); // separated by hyphen

      // heading and trailing whitespaces
      assert(userInputRegExp.hasMatch("     cat"));
      assert(userInputRegExp.hasMatch("cat     "));
      assert(userInputRegExp.hasMatch("   cat  "));
    });
    test("Invalid Input", () {
      // begin with an invalid character
      assert(!userInputRegExp.hasMatch("-dog"));
      assert(!userInputRegExp.hasMatch("_dog"));

      // phrase separated by underscore
      assert(!userInputRegExp.hasMatch("golden_retriever"));

      // phrase separated by two or more spaces
      assert(!userInputRegExp.hasMatch("golden  retriever"));
      assert(!userInputRegExp.hasMatch("golden   retriever"));

      // end with a non-latin letter
      assert(!userInputRegExp.hasMatch("dog-"));
      assert(!userInputRegExp.hasMatch("       dog-"));
      assert(!userInputRegExp.hasMatch("dog-       "));
      assert(!userInputRegExp.hasMatch("dog_!@#"));

      // random invalid characters
      assert(!userInputRegExp.hasMatch("!@#\$%^&*()_+[]{}\\|;:,./<>?'\""));
    });
  });
}
