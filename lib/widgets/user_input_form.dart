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
  void dispose() {
    _userInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: _userInputController,
          validator: (String? value) {
            if (value != null) {
              return trimmedUserInputRegExp.hasMatch(value.trim())
                  ? null
                  : inputFormatHelpMsg;
            }
            return null;
          },
          autocorrect: true, // this may be a patch for user typos
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Type your answer',
          ),
        ));
  }
}
