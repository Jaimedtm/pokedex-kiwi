import 'dart:convert';

import 'package:http/http.dart' as http;

class PokemonApiManager {
  final String url = 'https://pokeapi.co/api/v2/pokemon/';
  static PokemonApiManager _instance = PokemonApiManager._internal();

  //Singleton, because we don´t need multiples instances of PokemonApiManager
  factory PokemonApiManager() {
    return _instance;
  }
  PokemonApiManager._internal();
  Future<dynamic> getFivePokemons() async {
    //TODO: Change the value in the for to get more pokemons
    List<Map<String, dynamic>> pokemonList = [];
    for (int i = 1; i <= 5; i++) {
      try {
        http.Response resp = await http
            .get(url + '$i')
            .timeout(Duration(seconds: 10), onTimeout: () => throw 'Timeout error');
        if (resp.statusCode == 200) {
          Map<String, dynamic> result = jsonDecode(resp.body);
          pokemonList.add(result);
        } else if (resp.statusCode >= 400) {
          throw FetchException(statuCode: resp.statusCode);
        }
      } on FetchException catch (e) {
        return e.description;
      } catch (e) {
        return 'Warning unhandled error: $e';
      }
    }
    return pokemonList;
  }
}

class FetchException implements Exception {
  int statuCode;
  FetchException({this.statuCode = -1});
  String get description {
    switch (statuCode) {
      case 400:
        return 'Bad request';
        break;
      case 401:
        return 'Resource not found';
        break;
      case 403:
        return 'forbidden access';
        break;
      case 404:
        return 'Resource not found';
        break;
      default:
        return 'Unknown error, please report to support area';
    }
  }
}
