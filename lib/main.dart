import 'package:book_tracker/routes.dart';
import 'package:book_tracker/theme/style_dark.dart' as dark_theme;
import 'package:book_tracker/theme/style.dart' as light_theme;

import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BookTracker(),
  );
}

class BookTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: light_theme.theme,
      darkTheme: dark_theme.theme,
      themeMode: ThemeMode.light, // testing, defaults to .system
      supportedLocales: <Locale>[
        Locale('en'),
        Locale('it'),
      ],
      localizationsDelegates: <LocalizationsDelegate>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      routes: routes,
    );
  }
}
