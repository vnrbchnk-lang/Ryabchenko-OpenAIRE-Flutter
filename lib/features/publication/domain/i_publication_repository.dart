import 'package:openaire_publications/features/publication/domain/publication_details_model.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';

abstract interface class IPublicationRepository {
  Future<List<PublicationModel>> getPublications({
    required int page,
    required int pageSize,
  });

  Future<PublicationDetailsModel> getDetails(String id);

  Future<List<PublicationModel>> searchPublications(String query);
}
