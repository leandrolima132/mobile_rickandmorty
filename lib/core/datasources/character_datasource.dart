import 'package:mobile_rickandmorty/domain/entities/character.dart';

abstract class CharacterDatasource {
  Future<List<Character>> getCharacters({int page = 1});
}
