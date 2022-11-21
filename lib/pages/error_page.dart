import 'package:flutter/material.dart';

import 'package:object_guesser/log.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  const ErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    log.wtf(errorMessage);

    return const Scaffold(
      body: Center(child: Text("Oops! Something is wrong...🤡")),
    );
  }
}
