import 'package:flutter/material.dart';
import 'package:pokedex/src/models/PokemonModel.dart';
import 'package:pokedex/src/widgets/PokemonCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String url =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/x-y/1.png';
    final PokemonModel bulbasaur =
        PokemonModel('Bulbasaur', url, 1, [PokemonTypes.ice, PokemonTypes.poison]);
    return Scaffold(
      body: Center(
        child: Container(
          child: PokemonCard(
            pokemon: bulbasaur,
          ),
        ),
      ),
    );
  }
}
