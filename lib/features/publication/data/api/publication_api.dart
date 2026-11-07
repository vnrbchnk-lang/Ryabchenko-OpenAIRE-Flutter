import 'package:dio/dio.dart';
import 'package:openaire_publications/features/publication/data/dto/publication_dto.dart';
import 'package:openaire_publications/features/publication/data/dto/publication_page_dto.dart';

final class PublicationApi {
  const PublicationApi(this._dio);

  final Dio _dio;

  static const String _types = 'publication,dataset,software';

  Future<PublicationPageDto> getPublicationPage({
    required int page,
    required int pageSize,
    String? title,
    String? subject,
  }) async {
    final json = await _getJson(
      '/researchProducts',
      queryParameters: {
        'type': _types,
        'page': page,
        'pageSize': pageSize,
        'mainTitle': ?title,
        'subjects': ?subject,
      },
    );
    return PublicationPageDto.fromJson(json);
  }

  Future<PublicationDto> getPublication(String id) async =>
      PublicationDto.fromJson(await _getJson('/researchProducts/$id'));

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return response.data ?? (throw const FormatException('Пустой ответ'));
  }
}
