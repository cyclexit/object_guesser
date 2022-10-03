import 'package:flutter/material.dart';

import 'package:object_guesser/game/user_input_regex.dart';
import 'package:object_guesser/ui/size_helper.dart';
import 'package:object_guesser/ui/widgets/next_button.dart';

class UserInputForm extends StatefulWidget {
  const UserInputForm({Key? key}) : super(key: key);

  @override
  State<UserInputForm> createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _userInputController = TextEditingController();

  // TODO:
  // 1. Add the game mode header
  // 2. Add the image placeholder
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          height: percentageHeight(context, 0.75),
          decoration: BoxDecoration(
              // TODO: remove the colorful border when the game pages are done.
              border: Border.all(color: Colors.lightBlue),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
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
                            content: Text(
                                "You enter: ${_userInputController.text.trim()}")),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
