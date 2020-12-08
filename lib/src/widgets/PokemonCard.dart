import 'dart:math';
import 'package:pokedex/src/models/PokemonModel.dart';
import 'package:pokedex/src/utils/Constanst.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonCard({@required this.pokemon, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            minHeight: 100, maxHeight: 110, minWidth: 250, maxWidth: 320),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400], offset: Offset(0.5, 1.5), blurRadius: 3)
          ],
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: _gradientColorChooser(pokemon.types[0])),
        ),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned(
              top: -15,
              right: -20,
              child: _pokeballBackground(),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 30, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: _pokemonInfo(),
                  ),
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      pokemon.url,
                      height: 70,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  TextStyle _fontStyle({Color color = Colors.white, double size = 18}) {
    return GoogleFonts.montserrat(color: color, fontSize: size);
  }

  List<Color> _gradientColorChooser(PokemonTypes t) {
    List<Color> _colors;
    switch (t) {
      case PokemonTypes.grass:
        _colors = [Color(0xFF86D683), Color(0xFF83D6B4)];
        break;
      case PokemonTypes.poison:
        _colors = [Color(0xFFBA3BCF), Color(0xFFF56061)];
        break;
      case PokemonTypes.ice:
        _colors = [Color(0xFFD3FEFB), Color(0xFF25D0C3)];
        break;
      case PokemonTypes.steel:
        _colors = [Color(0xFFEAEAEA), Color(0xFF8C8C8C)];
        break;
      case PokemonTypes.water:
        _colors = [Color(0xFF403DF0), Color(0xFF62DBFF)];
        break;
      case PokemonTypes.rock:
        _colors = [Color(0xFFBB620D), Color(0xFFFEC450)];
        break;
      case PokemonTypes.psychic:
        _colors = [Color(0xFFFF52D7), Color(0xFFFFAEAF)];
        break;
      case PokemonTypes.normal:
        _colors = [Color(0xFFE8E6CD), Color(0xFFC7BBA2)];
        break;
      case PokemonTypes.ground:
        _colors = [Color(0xFFFFCC52), Color(0xFFEC9B25)];
        break;
      case PokemonTypes.ghost:
        _colors = [Color(0xFFA016DA), Color(0xFF7F52FF)];
        break;
      case PokemonTypes.flying:
        _colors = [Color(0xFF5DC3FF), Color(0xFFE6F1FF)];
        break;
      case PokemonTypes.fire:
        _colors = [Color(0xFFFD5A5A), Color(0xFFFBE857)];
        break;
      case PokemonTypes.fighting:
        _colors = [Color(0xFFE06236), Color(0xFFECA58C)];
        break;
      case PokemonTypes.fairy:
        _colors = [Color(0xFFE036A7), Color(0xFFFDB4BC)];
        break;
      case PokemonTypes.electric:
        _colors = [Color(0xFFFFD000), Color(0xFFFFEDAD)];
        break;
      case PokemonTypes.dragon:
        _colors = [Color(0xFF923BFF), Color(0xFFAEE9FF)];
        break;
      case PokemonTypes.dark:
        _colors = [Color(0xFF343434), Color(0xFFB2B2B2)];
        break;
      case PokemonTypes.bug:
        _colors = [Color(0xFFDEC953), Color(0xFFE8FF63)];
        break;
    }
    return _colors;
  }

  String _fixedIndex(int index) {
    String result;
    if (index > 99) {
      result = '#$index';
    } else if (index > 9) {
      result = '#0$index';
    } else {
      result = '#00$index';
    }
    return result;
  }

  List<Widget> _cardLabels() {
    List<Widget> labels = [];
    int typesInt = pokemon.types.length - 1;
    for (int i = 0; i <= typesInt; i++) {
      //In this case forEach or for in isn´t an option, becase we need the index
      //to know when add a sizeBox as spacer
      labels.add(PokemonTypeLabel(type: pokemon.types[i]));
      if (i != typesInt)
        labels.add(SizedBox(
          width: 5,
        ));
    }
    return labels;
  }

  /* Need the pokemon model to know the name, number and types*/
  Widget _pokemonInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Text(_fixedIndex(pokemon.index),
              style: _fontStyle(size: 15, color: Colors.white.withOpacity(0.7))),
        ),
        Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 3,
          child: Text(pokemon.name, style: _fontStyle(size: 18)),
        ),
        Spacer(
          flex: 3,
        ),
        Flexible(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: _cardLabels(),
          ),
        ),
      ],
    );
  }

  // Neee the url of pokemon sprite
  Widget _pokeballBackground() {
    return Container(
      width: 150,
      height: 150,
      child: Transform.rotate(
        angle: pi / 4,
        child: SvgPicture.asset('res/svg/pokeball.svg',
            color: Colors.white.withOpacity(0.3)),
      ),
    );
  }
}

class PokemonTypeLabel extends StatelessWidget {
  final PokemonTypes type;
  PokemonTypeLabel({@required this.type, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> _colorAndText = _textAndColorChooser(type);
    final Color color = _colorAndText[0];
    final String pokemonTypeString = _colorAndText[1];
    return Container(
      constraints: BoxConstraints(maxHeight: 25, minWidth: 60, maxWidth: 78),
      width: (pokemonTypeString.length * 13).toDouble(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white.withOpacity(0.3)),
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      child: Text(
        pokemonTypeString,
        style: _fontStyle(color: color, size: 12),
      ),
    );
  }

  TextStyle _fontStyle({Color color = Colors.white, double size = 18}) {
    return GoogleFonts.montserrat(color: color, fontSize: size);
  }

  List<dynamic> _textAndColorChooser(PokemonTypes t) {
    Color color;
    switch (t) {
      case PokemonTypes.grass:
        color = Color(0xFF3B5F3A);
        break;
      case PokemonTypes.poison:
        color = Color(0xFF5F3A5B);
        break;
      case PokemonTypes.ice:
        color = Color(0xFF4B90A4);
        break;
      case PokemonTypes.steel:
        color = Color(0xFF5F5F5F);
        break;
      case PokemonTypes.water:
        color = Color(0xFF416395);
        break;
      case PokemonTypes.rock:
        color = Color(0xFF955D41);
        break;
      case PokemonTypes.psychic:
        color = Color(0xFFBD59BA);
        break;
      case PokemonTypes.normal:
        color = Color(0xFF8F8A81);
        break;
      case PokemonTypes.ground:
        color = Color(0xFF835B13);
        break;
      case PokemonTypes.ghost:
        color = Color(0xFF5A1383);
        break;
      case PokemonTypes.flying:
        color = Color(0xFF488BC7);
        break;
      case PokemonTypes.fire:
        color = Color(0xFFD46333);
        break;
      case PokemonTypes.fighting:
        color = Color(0xFF9C4722);
        break;
      case PokemonTypes.fairy:
        color = Color(0xFF9C226A);
        break;
      case PokemonTypes.electric:
        color = Color(0xFF9C6F22);
        break;
      case PokemonTypes.dragon:
        color = Color(0xFF61229C);
        break;
      case PokemonTypes.dark:
        color = Color(0xFF494949);
        break;
      case PokemonTypes.bug:
        color = Color(0xFF8C9E26);
        break;
    }
    return <dynamic>[color, pokemonTypesStringList[t.index]];
  }
}
