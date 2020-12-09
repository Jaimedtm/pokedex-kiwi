import 'package:flutter/material.dart';
import 'package:pokedex/src/routes/route.dart';

void main() {
  runApp(MaterialApp(
    title: 'Pokedex',
    initialRoute: '/',
    routes: getRoutes(),
    theme: ThemeData(accentColor: Colors.red[400], primarySwatch: Colors.red),
  ));
}
