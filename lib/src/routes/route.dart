import 'package:flutter/material.dart';
import 'package:pokedex/src/pages/HomePage.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
  };
}
