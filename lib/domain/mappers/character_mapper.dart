import 'package:mobile_rickandmorty/domain/entities/character.dart';
import 'package:mobile_rickandmorty/domain/models/character_model.dart';

// Mapper: Converte Model (estrutura da API) -> Entity (objeto de domínio)
class CharacterMapper {
  static Character toEntity(CharacterModel model) {
    return Character(
      id: model.id,
      name: model.name,
      status: model.status,
      species: model.species,
      type: model.type,
      gender: model.gender,
      origin: model.origin.name,
      location: model.location.name,
      image: model.image,
      episode: model.episode,
      url: model.url,
      created: DateTime.parse(model.created),
    );
  }

  static List<Character> toEntityList(List<CharacterModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }
}
