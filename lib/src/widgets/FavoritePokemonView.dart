import 'package:flutter/material.dart';
import 'package:pokedex/src/models/PokemonModel.dart';
import 'package:pokedex/src/pages/DescriptionPage.dart';
import 'package:pokedex/src/widgets/SlidePageRoute.dart';

class FavoritePokemosView extends StatelessWidget {
  final PokemonModel pokemon;
  const FavoritePokemosView({this.pokemon, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      constraints:
          BoxConstraints(maxHeight: screen.width / 4, maxWidth: screen.width / 4),
      height: 100,
      width: 100,
      child: pokemon == null
          ? Image.asset('res/img/pokeball_2.png')
          : GestureDetector(
              onTap: () {
                Navigator.of(context).push(SlidePageRoute(DescriptionPage(
                  pokemon: pokemon,
                )));
              },
              child: Image.network(pokemon.url),
            ),
    );
  }
}
