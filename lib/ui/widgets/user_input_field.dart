import 'package:flutter/material.dart';

import 'package:object_guesser/game/user_input_regex.dart';

class UserInputField extends StatelessWidget {
  const UserInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
      child: TextFormField(
        validator: (String? value) {
          if (value != null) {
            return userInputRegExp.hasMatch(value) ? null : inputFormatHelpMsg;
          }
          return null;
        },
        autocorrect: true, // this may be a patch for user typos
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Type your answer',
        ),
      ),
    );
  }
}
