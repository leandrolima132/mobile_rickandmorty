import 'package:mobile_rickandmorty/core/datasources/character_datasource.dart';
import 'package:mobile_rickandmorty/core/service/api_service.dart';
import 'package:mobile_rickandmorty/domain/entities/character.dart';
import 'package:mobile_rickandmorty/domain/mappers/character_mapper.dart';
import 'package:mobile_rickandmorty/domain/models/character_response_model.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final ApiService _apiService = ApiService();

  @override
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _apiService.get('/character', queryParameters: {
        'page': page,
      });

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      final data = response.data as Map<String, dynamic>;
      final responseModel = CharacterResponseModel.fromJson(data);

      // Converte Model -> Entity usando o Mapper
      return CharacterMapper.toEntityList(responseModel.results);
    } catch (e) {
      rethrow;
    }
  }
}
