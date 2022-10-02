import 'package:flutter/material.dart';

import 'package:object_guesser/ui/forms/user_input_form.dart';

// The about page is used for temporary UI components visualization during the
// development.
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Align(
          alignment: Alignment.bottomCenter, child: UserInputForm()),
    );
  }
}
