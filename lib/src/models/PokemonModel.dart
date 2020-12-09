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
  int baseExperience;
  double height;
  double weight;
  List<String> abilities;
  List<PokemonStats> stats;
  List<PokemonTypes> types;

  PokemonModel(this.name, this.url, this.index, this.types, this.stats,
      this.abilities, this.baseExperience, this.height, this.weight);
  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    List<PokemonTypes> types = [];
    List<PokemonStats> statsList = [];
    List<String> abilities = [];
    String url = map['sprites']['other']['official-artwork']['front_default'];
    for (var type in map['types']) {
      int index = pokemonTypesStringList.indexOf(capitalize(type['type']['name']));
      types.add(PokemonTypes.values[index]);
    }
    for (var stat in map['stats']) {
      statsList
          .add(PokemonStats(capitalize(stat['stat']['name']), stat['base_stat']));
    }
    for (var ability in map['abilities']) {
      abilities.add(capitalize(ability['ability']['name']));
    }
    return PokemonModel(capitalize(map['name']), url, map['id'], types, statsList,
        abilities, map['base_experience'], map['height'] / 10, map['weight'] / 10);
  }

  List<String> get stringTypes {
    List<String> list = [];
    for (PokemonTypes type in types) {
      list.add(pokemonTypesStringList[type.index]);
    }
    return list;
  }
}

class PokemonStats {
  int baseStat;
  String statName;

  PokemonStats(this.statName, this.baseStat);
}
