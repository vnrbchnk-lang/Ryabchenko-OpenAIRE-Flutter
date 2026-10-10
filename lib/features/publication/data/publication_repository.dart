import 'package:openaire_publications/features/publication/data/mock_publications.dart';
import 'package:openaire_publications/features/publication/domain/i_publication_repository.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';

final class PublicationRepository implements IPublicationRepository {
  const PublicationRepository();

  @override
  Future<List<PublicationModel>> getPublications() async => mockPublications;

  @override
  Future<PublicationModel?> getPublication(String id) async {
    for (final publication in mockPublications) {
      if (publication.id == id) return publication;
    }
    return null;
  }

  @override
  Future<List<PublicationModel>> searchPublications(String query) async {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return mockPublications;
    return [
      for (final publication in mockPublications)
        if (publication.mainTitle.toLowerCase().contains(needle)) publication,
    ];
  }

  @override
  Future<List<PublicationModel>> getRelated(
    PublicationModel publication,
  ) async {
    return [
      for (final other in mockPublications)
        if (other.id != publication.id &&
            other.subjects.any(publication.subjects.contains))
          other,
    ];
  }
}
