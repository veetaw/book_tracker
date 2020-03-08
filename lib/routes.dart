import 'package:book_tracker/screens/book_details/book_details.dart';
import 'package:book_tracker/screens/home/home.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => Home(),
  '/details': (context) => BookDetails(),
};
