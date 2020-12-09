import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/services/DatabaseEmule.dart';
import 'package:pokedex/src/widgets/FavoritePokemonView.dart';

class TrainerCardPage extends StatelessWidget {
  const TrainerCardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseEmule db = DatabaseEmule();
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screen.height,
        width: screen.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Trainer Card',
              style: _fontStyle(size: 20, bold: true),
            ),
            Image.asset(
              'res/img/trainer.png',
              height: screen.height / 3,
            ),
            _favPokemons(screen, db.favorites),
          ],
        ),
      ),
      backgroundColor: Color(0xFF923BFF),
    );
  }

  TextStyle _fontStyle(
      {Color color = Colors.white, double size = 18, bool bold = false}) {
    return GoogleFonts.montserrat(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.w500 : FontWeight.normal);
  }

  Widget _favPokemons(Size screen, List<PokemonModel> pokemons) {
    List<Widget> _list = [];
    pokemons.forEach((pokemon) {
      _list.add(FavoritePokemosView(
        pokemon: pokemon,
      ));
    });
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      padding: EdgeInsets.all(20),
      width: screen.width - 20,
      height: screen.height / 2.3,
      child: Column(
        children: [
          Text(
            'Favorites',
            style: _fontStyle(color: Colors.black87),
          ),
          Divider(
            color: Colors.black26,
            endIndent: 20,
            indent: 20,
            thickness: 3,
          ),
          Container(
            height: screen.height * 0.30,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children: _list,
            ),
          )
        ],
      ),
    );
  }
}
