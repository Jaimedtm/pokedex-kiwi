import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/src/models/PokemonModel.dart';
import 'package:pokedex/src/utils/functions.dart';
import 'package:pokedex/src/widgets/FavoriteButton.dart';
import 'package:pokedex/src/widgets/PokemonCard.dart';

class DescriptionPage extends StatefulWidget {
  final PokemonModel pokemon;
  const DescriptionPage({@required this.pokemon, Key key}) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColorChooser(widget.pokemon.types[0]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          _pokemonInfo(widget.pokemon),
          Divider(
            color: Colors.white38,
            endIndent: 20,
            indent: 20,
            height: 1,
            thickness: 3,
          ),
          _statsInfo(widget.pokemon),
          _pokemonMoreInfo(widget.pokemon)
        ],
      ),
    );
  }

  TextStyle _fontStyle(
      {Color color = Colors.white, double size = 18, bool bold = false}) {
    return GoogleFonts.montserrat(
        color: color,
        fontSize: size,
        fontWeight: bold ? FontWeight.w500 : FontWeight.normal);
  }

  Color _backgroundColorChooser(PokemonTypes type) {
    Color color;
    switch (type) {
      case PokemonTypes.grass:
        color = Color(0xFF86D683);
        break;
      case PokemonTypes.poison:
        color = Color(0xFFBA3BCF);
        break;
      case PokemonTypes.ice:
        color = Color(0xFFD3FEFB);
        break;
      case PokemonTypes.steel:
        color = Color(0xFFEAEAEA);
        break;
      case PokemonTypes.water:
        color = Color(0xFF403DF0);
        break;
      case PokemonTypes.rock:
        color = Color(0xFFBB620D);
        break;
      case PokemonTypes.psychic:
        color = Color(0xFFFF52D7);
        break;
      case PokemonTypes.normal:
        color = Color(0xFFE8E6CD);
        break;
      case PokemonTypes.ground:
        color = Color(0xFFFFCC52);
        break;
      case PokemonTypes.ghost:
        color = Color(0xFFA016DA);
        break;
      case PokemonTypes.flying:
        color = Color(0xFF5DC3FF);
        break;
      case PokemonTypes.fire:
        color = Color(0xFFFD5A5A);
        break;
      case PokemonTypes.fighting:
        color = Color(0xFFE06236);
        break;
      case PokemonTypes.fairy:
        color = Color(0xFFE036A7);
        break;
      case PokemonTypes.electric:
        color = Color(0xFFFFD000);
        break;
      case PokemonTypes.dragon:
        color = Color(0xFF923BFF);
        break;
      case PokemonTypes.dark:
        color = Color(0xFF343434);
        break;
      case PokemonTypes.bug:
        color = Color(0xFFDEC953);
        break;
    }
    return color;
  }

  Widget _pokemonInfo(PokemonModel pokemon) {
    return Stack(
      children: [
        Positioned(
          top: 30,
          right: -25,
          child: Transform.rotate(
            angle: pi * 0.25,
            child: SvgPicture.asset(
              'res/svg/pokeball.svg',
              color: Colors.white30,
              height: 180,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: double.infinity,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fixedIndex(pokemon.index),
                      style: _fontStyle(color: Colors.white70, size: 20)),
                  Text(pokemon.name, style: _fontStyle(size: 25)),
                  SizedBox(height: 20),
                  Row(
                    children: _cardLabels(),
                  ),
                  SizedBox(height: 10),
                  FavoriteButton(
                      pokemon: widget.pokemon,
                      color: _backgroundColorChooser(widget.pokemon.types[0]))
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Image.network(
                pokemon.url,
                height: 150,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statsInfo(PokemonModel pokemon) {
    final List<String> allowedStats = [
      'Hp',
      'Attack',
      'Defense',
      'Speed',
    ];
    List<Widget> stats = [];
    for (PokemonStats stat in pokemon.stats) {
      if (allowedStats.contains(stat.statName)) {
        stats.add(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${stat.statName}',
              style: _fontStyle(color: Colors.black87, size: 16, bold: true),
            ),
            Text(
              '${stat.baseStat}',
              style: _fontStyle(color: Colors.black87, size: 13),
            )
          ],
        ));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Base stats',
          style: _fontStyle(size: 20, bold: true),
        ),
        SizedBox(height: 5),
        Container(
          constraints: BoxConstraints(maxHeight: 100, maxWidth: 300),
          width: 350,
          height: 85,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: stats),
        ),
      ],
    );
  }

  Widget _pokemonMoreInfo(PokemonModel pokemon) {
    final List<String> allowedStats = [
      'Special-attack',
      'Special-defense',
    ];
    String abilitiesString = '';
    List<Widget> stats = [];
    for (PokemonStats stat in pokemon.stats) {
      if (allowedStats.contains(stat.statName)) {
        stats.add(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${stat.statName}',
              style: _fontStyle(color: Colors.black87, size: 16, bold: true),
            ),
            Text(
              '${stat.baseStat}',
              style: _fontStyle(color: Colors.black87, size: 13),
            )
          ],
        ));
      }
    }
    for (int i = 0; i < pokemon.abilities.length; i++) {
      if (i != pokemon.abilities.length - 1) {
        abilitiesString += '${pokemon.abilities[i]}, ';
      } else {
        abilitiesString += '${pokemon.abilities[i]}';
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More about ${pokemon.name}',
          style: _fontStyle(size: 20, bold: true),
        ),
        SizedBox(height: 5),
        Container(
          constraints: BoxConstraints(maxHeight: 300, maxWidth: 300),
          width: 350,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: stats),
              Row(
                children: [
                  Text('Abilities: ',
                      style:
                          _fontStyle(color: Colors.black87, size: 18, bold: true)),
                  Text(abilitiesString,
                      style: _fontStyle(color: Colors.black87, size: 13))
                ],
              ),
              Row(
                children: [
                  Text('Base experience: ',
                      style:
                          _fontStyle(color: Colors.black87, size: 18, bold: true)),
                  Text('${pokemon.baseExperience}',
                      style: _fontStyle(color: Colors.black87, size: 13))
                ],
              ),
              Row(
                children: [
                  Text('Height: ',
                      style:
                          _fontStyle(color: Colors.black87, size: 18, bold: true)),
                  Text('${pokemon.height} m',
                      style: _fontStyle(color: Colors.black87, size: 13))
                ],
              ),
              Row(
                children: [
                  Text('Weight: ',
                      style:
                          _fontStyle(color: Colors.black87, size: 18, bold: true)),
                  Text('${pokemon.weight} Kg',
                      style: _fontStyle(color: Colors.black87, size: 13))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _cardLabels() {
    List<Widget> labels = [];
    int typesInt = widget.pokemon.types.length - 1;
    for (int i = 0; i <= typesInt; i++) {
      labels.add(PokemonTypeLabel(
        type: widget.pokemon.types[i],
        transparent: false,
      ));
      if (i != typesInt)
        labels.add(SizedBox(
          width: 5,
        ));
    }
    return labels;
  }
}
