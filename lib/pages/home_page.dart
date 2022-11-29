import 'package:flutter/material.dart';

import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/pages/error_page.dart';
import 'package:object_guesser/pages/loading_page.dart';
import 'package:object_guesser/services/firestore_service.dart';
import 'package:object_guesser/widgets/category_button.dart';
import 'package:object_guesser/widgets/home_page_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Widget> _buildCategoryButtons(List<Label> categoryList) {
    List<Widget> buttons = [];
    for (final label in categoryList) {
      buttons.add(CategoryButton(category: Category.fromLabel(label)));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return FutureBuilder(
        future: FirestoreService().getCategories(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else if (snapshot.hasError) {
            return ErrorPage(errorMessage: snapshot.error.toString());
          } else if (snapshot.hasData) {
            final categoryList = snapshot.data!;
            return Scaffold(
                body: Column(
              children: [
                const HomePageHeader(),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Categories",
                          style: theme.textTheme.headline2,
                        ),
                        const SizedBox(height: 16.0),
                        GridView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 120,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          children: _buildCategoryButtons(categoryList),
                        )
                      ]),
                ),
              ],
            ));
          }
          return const Text('No Categories');
        }));
  }
}
