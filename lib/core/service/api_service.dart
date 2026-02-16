import 'package:dio/dio.dart';
import 'package:mobile_rickandmorty/core/utils/storage_utils.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Dio? _dio;
  static const String _baseUrl = 'https://rickandmortyapi.com/api';
  final _storageUtils = StorageUtils();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storageUtils.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));

    _isInitialized = true;
  }

  Future<Response<dynamic>> get(String path,
      {Map<String, dynamic> queryParameters = const {},
      bool isAuth = false}) async {
    if (!_isInitialized || _dio == null) {
      throw Exception('ApiService not initialized. Call init() first.');
    }

    try {
      print(
          'DioRequest >>>> [Endpoint: (GET) $path] : [QueryParameters: $queryParameters]');
      final response = await _dio!.get(path, queryParameters: queryParameters);
      // quantos characters foram retornados por pagina
      print('Count: ${response.data['info']['count']}');
      print('Pages: ${response.data['info']['pages']}');
      print(
          'DioResponse <<<< [Endpoint: (GET) $path] : [Status: ${response.statusCode}]');
      return response;
    } on DioException catch (e) {
      print('DioError <<<< [Endpoint: (GET) $path] : [Error: ${e.message}]');
      print('DioError <<<< [Response: ${e.response?.data}]');
      throw Exception('Failed to load data: ${e.message}');
    } catch (e) {
      print('DioError <<<< [Endpoint: (GET) $path] : [Error: $e]');
      throw Exception('Unexpected error: $e');
    }
  }
}
