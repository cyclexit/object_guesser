import 'package:flutter/material.dart';
import 'package:object_guesser/ui/widgets/next_button.dart';

import 'package:object_guesser/ui/widgets/user_input_field.dart';

// The about page is used for temporary UI components visualization during the
// development.
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [const UserInputField(), NextButton(onPressed: () {})],
        ),
      ),
    );
  }
}
