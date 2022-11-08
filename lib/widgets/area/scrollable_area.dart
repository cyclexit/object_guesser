import 'package:flutter/material.dart';

class ScrollableArea extends StatelessWidget {
  final Widget top;
  final Widget middle;
  final Widget bottom;

  const ScrollableArea(
      {super.key,
      required this.top,
      required this.middle,
      required this.bottom});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          height: 15.0,
        ),
        top,
        const SizedBox(
          height: 30.0,
        ),
        middle,
        const SizedBox(
          height: 15.0,
        ),
        bottom
      ]),
    );
  }
}
