import 'package:flutter/material.dart';
import 'package:pokedex/src/models/PokemonModel.dart';
import 'package:pokedex/src/services/PokemonApiManager.dart';
import 'package:pokedex/src/widgets/PokemonCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonApiManager apiManager = PokemonApiManager();
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
            future: apiManager.getFivePokemons(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data is List<Map<String, dynamic>>) {
                var data = snapshot.data as List<Map<String, dynamic>>;
                List<PokemonModel> pokemonList = [];
                for (Map pokemonMap in data) {
                  pokemonList.add(PokemonModel.fromMap(pokemonMap));
                }
                return Container(
                  height: screen.height - 150,
                  child: ListView.builder(
                    itemCount: pokemonList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == pokemonList.length - 1) {
                        return PokemonCard(pokemon: pokemonList[index]);
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PokemonCard(pokemon: pokemonList[index]),
                            SizedBox(height: 20)
                          ],
                        );
                      }
                    },
                  ),
                );
              } else {
                return Text('opps!');
              }
            },
          ),
        ),
      ),
    );
  }
}
