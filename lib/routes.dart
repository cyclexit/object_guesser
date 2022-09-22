import 'dart:js';

import 'package:object_guesser/login/login.dart';
import 'package:object_guesser/about/about.dart';
import 'package:object_guesser/home/home.dart';

var appRoutes = {
  '/': (context) => const LoginPage(),
  '/about': (context) => const AboutPage(),
  '/home': (context) => const HomePage()
};
