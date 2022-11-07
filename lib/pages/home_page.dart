import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: (() => Navigator.pushNamed(context, '/quiz')),
          child: const Text("play")),
    );
  }
}
