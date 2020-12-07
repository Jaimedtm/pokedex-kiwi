import 'package:flutter/material.dart';
import 'package:pokedex/src/routes/route.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: getRoutes(),
  ));
}
