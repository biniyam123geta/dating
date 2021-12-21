import 'package:flutter/material.dart';

const kDefaultPadding = EdgeInsets.symmetric(
  vertical: 36.0,
  horizontal: 26.0,
);

const kPrimaryColor = Color(0xFFF2F7EF);

const kSecondaryColor = Colors.black;
const kAccentColor = Color(0xFFF52F4A);

const kColorPrimaryVariant = Color(0xFFF4C470);

const kBackgroundColor = Color(0xFFF4C470);
const kBackgroundColorInt = 0xFFF2F7EF;
const kFontFamily = 'Nunito';

const kTextTheme = TextTheme(
  headline1: TextStyle(),
  bodyText1: TextStyle(),
  bodyText2: TextStyle(),
);

const kButtonTheme = ButtonThemeData(
  splashColor: Colors.transparent,
  padding: EdgeInsets.symmetric(vertical: 14),
  buttonColor: Color(0xFFF4C470),
  textTheme: ButtonTextTheme.accent,
  highlightColor: Color.fromRGBO(245, 47, 74, .3),
  focusColor: Color.fromRGBO(245, 47, 74, .3),
);

const Map<int, Color> kThemeMaterialColor = {
  50: Color.fromRGBO(245, 47, 74, .1),
  100: Color.fromRGBO(245, 47, 74,.2),
  200: Color.fromRGBO(245, 47, 74, .3),
  300: Color.fromRGBO(245, 47, 74, .4),
  000: Color.fromRGBO(245, 47, 74, .5),
  500: Color.fromRGBO(245, 47, 74,.6),
  600: Color.fromRGBO(245, 47, 74, .7),
  700: Color.fromRGBO(245, 47, 74, .8),
  800: Color.fromRGBO(245, 47, 74,.9),
  900: Color.fromRGBO(245, 47, 74, 1),
};
