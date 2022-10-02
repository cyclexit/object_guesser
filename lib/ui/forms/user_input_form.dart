import 'package:flutter/material.dart';

import 'package:object_guesser/game/user_input_regex.dart';
import 'package:object_guesser/ui/widgets/next_button.dart';

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
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
              child: TextFormField(
                controller: _userInputController,
                validator: (String? value) {
                  if (value != null) {
                    return userInputRegExp.hasMatch(value)
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: NextButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // TODO: replace the logic here with a call to the server or
                    // save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text("You enter: ${_userInputController.text}")),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
