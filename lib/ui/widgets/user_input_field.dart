import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  const UserInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        validator: (String? value) {
          if (value != null) {
            // TODO: validate the string with regex.
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
