import 'package:flutter/material.dart';
import 'package:object_guesser/models/category.dart';
import 'package:object_guesser/pages/login_page.dart';
import 'package:object_guesser/pages/about_page.dart';
import 'package:object_guesser/pages/main_page.dart';
import 'package:object_guesser/pages/quiz_page.dart';
import 'package:object_guesser/pages/quiz_result_page.dart';

var appRoutes = {
  MainPage.routeName: (context) => const MainPage(),
  AboutPage.routeName: (context) => const AboutPage(),
  LoginPage.routeName: (context) => const LoginPage(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  var routeName = settings.name;
  var arguments = settings.arguments;

  switch (routeName) {
    case QuizPage.routeName:
      if (arguments != null && arguments is Category) {
        return MaterialPageRoute(
            builder: (context) => QuizPage(category: arguments));
      }
      break;
    case QuizResultPage.routeName:
      if (arguments != null && arguments is Category) {
        return MaterialPageRoute(
            builder: (context) => QuizResultPage(category: arguments));
      }
  }
  return MaterialPageRoute(builder: (context) => const MainPage());
}
