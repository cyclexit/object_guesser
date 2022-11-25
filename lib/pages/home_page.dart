import 'package:flutter/material.dart';

import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/models/label.dart';
import 'package:object_guesser/pages/error_page.dart';
import 'package:object_guesser/pages/loading_page.dart';
import 'package:object_guesser/services/firestore_service.dart';
import 'package:object_guesser/widgets/category_button.dart';

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
                body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "Categories",
                          style: theme.textTheme.headline2,
                        ),
                      ),
                      GridView(
                        shrinkWrap: true,
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
            ));
          }
          return const Text('No topics found in Firestore. Check database');
        }));
  }
}
