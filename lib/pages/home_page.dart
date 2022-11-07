import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/widgets/category_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const categories = [
    Category(id: "id", name: "Animals", icon: FontAwesomeIcons.otter),
    Category(id: "id", name: "Vegetables", icon: FontAwesomeIcons.carrot),
    Category(id: "id", name: "Utensils", icon: FontAwesomeIcons.utensils),
    Category(id: "id", name: "Tools", icon: FontAwesomeIcons.toolbox),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Categories",
              style: theme.textTheme.headline2,
            ),
          ),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            children: [
              CategoryButton(
                category: categories[0],
              ),
              CategoryButton(
                category: categories[1],
              ),
              CategoryButton(
                category: categories[2],
              ),
              CategoryButton(
                category: categories[3],
              ),
            ],
          )
        ]),
      ),
    ));
=======

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: (() => Navigator.pushNamed(context, '/quiz')),
          child: const Text("play")),
    );
>>>>>>> master
  }
}
