// Model representa exatamente a estrutura da API
class LocationModel {
  final String name;
  final String url;

  LocationModel({
    required this.name,
    required this.url,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationModel origin;
  final LocationModel location;
  final String image;
  final List<String> episode;
  final String url;
  final String created; // Mantém como String (ISO 8601)

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      origin: LocationModel.fromJson(json['origin'] ?? {}),
      location: LocationModel.fromJson(json['location'] ?? {}),
      image: json['image'] ?? '',
      episode: json['episode'] != null
          ? List<String>.from(json['episode'])
          : <String>[],
      url: json['url'] ?? '',
      created: json['created'] ?? '',
    );
  }
}
