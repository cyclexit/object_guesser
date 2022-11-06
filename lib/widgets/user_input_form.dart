import 'package:flutter/material.dart';

import 'package:object_guesser/constants/user_input_regex.dart';

class UserInputForm extends StatefulWidget {
  const UserInputForm({Key? key}) : super(key: key);

  @override
  State<UserInputForm> createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _userInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _userInputController,
      validator: (String? value) {
        if (value != null) {
          return trimmedUserInputRegExp.hasMatch(value.trim())
              ? null
              : inputFormatHelpMsg;
        }
        return null;
      },
    );
  }
}
