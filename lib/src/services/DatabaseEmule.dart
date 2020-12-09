import 'package:pokedex/src/models/PokemonModel.dart';
export 'package:pokedex/src/models/PokemonModel.dart';

class DatabaseEmule {
  List<PokemonModel> _favorites = [];
  static DatabaseEmule _intsance = DatabaseEmule._internal();
  factory DatabaseEmule() {
    return _intsance;
  }
  DatabaseEmule._internal();

  List<PokemonModel> get favorites => _favorites;

  addFavorite(PokemonModel pokemon) => _favorites.add(pokemon);

  deleteFavorite(PokemonModel pokemon) => _favorites.remove(pokemon);
}
