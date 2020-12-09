import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/models/PokemonModel.dart';
import 'package:pokedex/src/services/PokemonApiManager.dart';
import 'package:pokedex/src/widgets/PokemonCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonApiManager apiManager = PokemonApiManager();
    Future pokemonsFuture = apiManager.getFivePokemons();
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokedex',
          style: _fontStyle(),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: FutureBuilder(
              future: pokemonsFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data is List<Map<String, dynamic>>) {
                  var data = snapshot.data as List<Map<String, dynamic>>;
                  List<PokemonModel> pokemonList = [];
                  for (Map pokemonMap in data) {
                    pokemonList.add(PokemonModel.fromMap(pokemonMap));
                  }
                  return Container(
                    height: screen.height - 180,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
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
                } else if (snapshot.data is Exception) {
                  return Text(
                    snapshot.data,
                    style: _fontStyle(size: 16),
                  );
                } else if (snapshot.data is FetchException) {
                  return Text(
                    'FetchE: ${snapshot.data.description}',
                    style: _fontStyle(size: 16),
                  );
                } else {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text(
                          'Loading...',
                          style: _fontStyle(size: 16, color: Colors.black87),
                        )
                      ]);
                }
              },
            ),
          ),
          _buttons(screen, pokemonsFuture),
        ],
      ),
    );
  }

  TextStyle _fontStyle({Color color = Colors.white, double size = 18}) {
    return GoogleFonts.montserrat(color: color, fontSize: size);
  }

  Widget _buttons(Size screen, Future future) {
    return Container(
      height: 70,
      width: screen.width,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: screen.width / 2,
              height: 150,
              child: FlatButton(
                color: Colors.red[400],
                child: Text(
                  'Show more Pokemons',
                  style: _fontStyle(size: screen.width / 25),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  future = null;
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: screen.width / 2,
              height: 150,
              child: FlatButton(
                color: Colors.red[300],
                child: Text(
                  'Trainer Card',
                  style: _fontStyle(size: screen.width / 20),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
