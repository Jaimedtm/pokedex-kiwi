import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokedex/src/routes/route.dart';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''),
    ],
    title: 'Pokedex',
    initialRoute: '/',
    routes: getRoutes(),
    theme: ThemeData(accentColor: Colors.red[400], primarySwatch: Colors.red),
  ));
}
