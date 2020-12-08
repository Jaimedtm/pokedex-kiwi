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
  final List<String> _stringTypes = [
    'Grass',
    'Poison',
    'Ice',
    'Steel',
    'Water',
    'Rock',
    'Psychic',
    'Normal',
    'Ground',
    'Ghost',
    'Flying',
    'Fire',
    'Fighting',
    'Fairy',
    'Electric',
    'Dragon',
    'Dark',
    'Bug'
  ];
  String name;
  String url;
  int index;
  List<PokemonTypes> types;

  PokemonModel(this.name, this.url, this.index, this.types);

  List<String> get stringTypes {
    List<String> list = [];
    for (PokemonTypes type in types) {
      list.add(_stringTypes[type.index]);
    }
    return list;
  }
}
