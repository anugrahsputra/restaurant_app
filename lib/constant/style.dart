import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// color scheme
const Color primaryColor = Color(0xff232F34);
const Color secondaryColor = Color(0xffF9AA33);

// typography
final textTheme = TextTheme(
  headline1: GoogleFonts.workSans(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.workSans(
      fontSize: 57, fontWeight: FontWeight.w600, letterSpacing: -0.5),
  headline3: GoogleFonts.workSans(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.workSans(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.workSans(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.workSans(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.workSans(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.workSans(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.workSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.workSans(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.workSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.workSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.workSans(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

var headline1 = textTheme.headline1;
