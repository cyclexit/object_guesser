import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xFF6845F5);
const secondaryColor = Color(0xFFAA96FC);
const tertiaryColor = Color(0xFFF6D094);
const whiteColor = Color(0xFFF5FAFB);
const blackColor = Color(0xFF2B2B2B);
const greenColor = Color(0xFF66AA4F);

const textTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: whiteColor),
    headline2: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: blackColor),
    subtitle1: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: blackColor),
    bodyText1: TextStyle(fontSize: 12.0, color: blackColor),
    bodyText2: TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w300, color: secondaryColor),
    button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold));

ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        shadow: blackColor.withOpacity(0.3),
        background: whiteColor),
    scaffoldBackgroundColor: whiteColor,
    textTheme: GoogleFonts.montserratTextTheme(textTheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: whiteColor,
            backgroundColor: blackColor,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))));
