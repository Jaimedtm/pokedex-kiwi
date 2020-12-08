import 'package:pokedex/src/utils/Constanst.dart';
import 'package:pokedex/src/utils/functions.dart';

enum PokemonTypes {
  grass,
  poison,
  ice,
  steel,
  water,
  rock,
  psychic,
  normal,
  ground,
  ghost,
  flying,
  fire,
  fighting,
  fairy,
  electric,
  dragon,
  dark,
  bug
}

class PokemonModel {
  String name;
  String url;
  int index;
  List<PokemonTypes> types;

  PokemonModel(this.name, this.url, this.index, this.types);
  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    List<PokemonTypes> types = [];
    String url = map['sprites']['other']['official-artwork']['front_default'];
    for (var type in map['types']) {
      int index = pokemonTypesStringList.indexOf(capitalize(type['type']['name']));
      types.add(PokemonTypes.values[index]);
    }
    return PokemonModel(capitalize(map['name']), url, map['id'], types);
  }

  List<String> get stringTypes {
    List<String> list = [];
    for (PokemonTypes type in types) {
      list.add(pokemonTypesStringList[type.index]);
    }
    return list;
  }
}
