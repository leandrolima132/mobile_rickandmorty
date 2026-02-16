import 'package:mobile_rickandmorty/domain/models/character_model.dart';
import 'package:mobile_rickandmorty/domain/models/infor_model.dart';

class CharacterResponseModel {
  final InfoModel info;
  final List<CharacterModel> results;

  CharacterResponseModel({
    required this.info,
    required this.results,
  });

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterResponseModel(
      info: InfoModel.fromJson(json['info'] ?? {}),
      results: json['results'] != null
          ? (json['results'] as List)
              .map((x) => CharacterModel.fromJson(x as Map<String, dynamic>))
              .toList()
          : <CharacterModel>[],
    );
  }
}
