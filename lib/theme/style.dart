import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primaryColor: Color(0xff4F67DD),
  primaryIconTheme: ThemeData.light().primaryIconTheme.copyWith(
        color: Color(0xff616161),
      ),
  scaffoldBackgroundColor: Color(0xffEEF0F3),
  primaryTextTheme: TextTheme(
    headline6: ThemeData.light().primaryTextTheme.title.apply(
          color: Colors.black,
        ),
  ),
  cardColor: Colors.white,
  brightness: Brightness.light,
);
