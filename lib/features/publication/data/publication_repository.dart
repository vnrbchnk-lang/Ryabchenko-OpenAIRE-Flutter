import 'package:openaire_publications/common/network/load_exception.dart';
import 'package:openaire_publications/features/publication/data/data_sources/i_publication_data_source.dart';
import 'package:openaire_publications/features/publication/data/dto/publication_page_dto.dart';
import 'package:openaire_publications/features/publication/data/mappers/publication_mapper.dart';
import 'package:openaire_publications/features/publication/domain/i_publication_repository.dart';
import 'package:openaire_publications/features/publication/domain/publication_details_model.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';

final class PublicationRepository implements IPublicationRepository {
  const PublicationRepository(this._dataSource);

  final IPublicationDataSource _dataSource;

  static const int _searchLimit = 20;
  static const int _relatedSubjects = 3;
  static const int _relatedPerSubject = 5;

  @override
  Future<List<PublicationModel>> getPublications({
    required int page,
    required int pageSize,
  }) async {
    final result = await _dataSource.getPublicationPage(
      page: page,
      pageSize: pageSize,
    );
    return [for (final dto in result.results) dto.toModel()];
  }

  @override
  Future<List<PublicationModel>> searchPublications(String query) async {
    final result = await _dataSource.getPublicationPage(
      page: 1,
      pageSize: _searchLimit,
      title: query.trim(),
    );
    return [for (final dto in result.results) dto.toModel()];
  }

  @override
  Future<PublicationDetailsModel> getDetails(String id) async {
    final publication = (await _dataSource.getPublication(id)).toModel();
    return PublicationDetailsModel(
      publication: publication,
      related: await _loadRelated(publication),
    );
  }

  Future<List<PublicationModel>> _loadRelated(
    PublicationModel publication,
  ) async {
    final List<PublicationPageDto> pages;
    try {
      pages = await Future.wait([
        for (final subject in publication.subjects.take(_relatedSubjects))
          _dataSource.getPublicationPage(
            page: 1,
            pageSize: _relatedPerSubject,
            subject: subject,
          ),
      ]);
    } on LoadException {
      return const [];
    }
    final related = <String, PublicationModel>{};
    for (final page in pages) {
      for (final dto in page.results) {
        if (dto.id != publication.id) {
          related.putIfAbsent(dto.id, dto.toModel);
        }
      }
    }
    return related.values.toList();
  }
}
