import 'package:pokedex/src/models/PokemonModel.dart';
import 'package:pokedex/src/services/PokemonApiManager.dart';
import 'package:test/test.dart';

void main() {
  group('Test API manager', () {
    PokemonApiManager apiManager = PokemonApiManager();
    test(
        'Test to verify that "apiManager.getFivePokemons()" return only the firts five pokemons',
        () async {
      List<Map<String, dynamic>> pokemonMapList = await apiManager.getFivePokemons();
      expect(5, pokemonMapList.length);
    });
    test('Test to verify that no one properties in PokemonModel are empty',
        () async {
      bool result = true;
      List<Map<String, dynamic>> pokemonMapList = await apiManager.getFivePokemons();
      List<PokemonModel> pokemons = [];
      pokemonMapList.forEach((map) => pokemons.add(new PokemonModel.fromMap(map)));
      pokemons.forEach((p) {
        result &= p.abilities != null;
        result &= p.baseExperience != null;
        result &= p.height != null;
        result &= p.index != null;
        result &= p.name != null;
        result &= p.stats != null;
        result &= p.types != null;
        result &= p.url != null;
        result &= p.weight != null;
      });
      expect(true, result);
    });
  });
}
