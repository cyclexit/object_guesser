import 'package:flutter/material.dart';

import 'package:object_guesser/services/get_image.dart';

// The about page is used for temporary UI components visualization during the
// development.
class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: getImage('data/img/dog-1.jpg'),
      ),
    );
  }
}
