import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:openaire_publications/common/network/load_exception.dart';
import 'package:openaire_publications/features/publication/data/api/publication_api.dart';
import 'package:openaire_publications/features/publication/data/data_sources/i_publication_data_source.dart';
import 'package:openaire_publications/features/publication/data/dto/publication_dto.dart';
import 'package:openaire_publications/features/publication/data/dto/publication_page_dto.dart';

final class NetworkPublicationDataSource implements IPublicationDataSource {
  const NetworkPublicationDataSource(this._api);

  final PublicationApi _api;

  @override
  Future<PublicationPageDto> getPublicationPage({
    required int page,
    required int pageSize,
    String? title,
    String? subject,
  }) => _guard(
    () => _api.getPublicationPage(
      page: page,
      pageSize: pageSize,
      title: title,
      subject: subject,
    ),
  );

  @override
  Future<PublicationDto> getPublication(String id) =>
      _guard(() => _api.getPublication(id));

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw _fromDio(error);
    } on CheckedFromJsonException {
      throw const BadResponseException();
    } on FormatException {
      throw const BadResponseException();
    }
  }

  LoadException _fromDio(DioException error) => switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutLoadException(),
    DioExceptionType.badResponse when error.response?.statusCode == 404 =>
      const NotFoundException(),
    DioExceptionType.badResponse => ServerException(error.response?.statusCode),
    DioExceptionType.unknown when error.error is FormatException =>
      const BadResponseException(),
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate ||
    DioExceptionType.cancel ||
    DioExceptionType.unknown => const NoConnectionException(),
  };
}
