import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primaryColor: Color(0xff5AD6F6),
  primaryColorLight: Color(0xff5AD6F6),
  primaryIconTheme: ThemeData.light().primaryIconTheme.copyWith(
        color: Colors.white,
      ),
  accentIconTheme: ThemeData.light().primaryIconTheme.copyWith(
        color: Color(0xff262E54),
      ),
  scaffoldBackgroundColor: Color(0xff262E54),
  primaryTextTheme: TextTheme(
    title: ThemeData.light().primaryTextTheme.title.apply(
          color: Colors.white,
        ),
  ),
  cardColor: Color(0xff333E72),
  brightness: Brightness.dark,
);
