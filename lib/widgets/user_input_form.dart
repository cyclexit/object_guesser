import 'package:flutter/material.dart';

import 'package:object_guesser/constants/user_input_regex.dart';

class UserInputForm extends StatefulWidget {
  final void Function(String?)? onSaved;

  const UserInputForm({Key? key, required this.onSaved}) : super(key: key);

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
          onChanged: (val) {
            // log.d("onChanged: User input: $val");
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
            }
          },
          onSaved: (val) {
            // log.d("onSaved: User input: $val");
            widget.onSaved!(val);
          },
          autocorrect: true, // this may be a patch for user typos
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Type your answer',
          ),
        ));
  }
}
