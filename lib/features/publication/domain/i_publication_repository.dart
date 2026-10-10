import 'package:openaire_publications/features/publication/domain/publication_model.dart';

abstract interface class IPublicationRepository {
  Future<List<PublicationModel>> getPublications();

  Future<PublicationModel?> getPublication(String id);

  Future<List<PublicationModel>> searchPublications(String query);

  Future<List<PublicationModel>> getRelated(PublicationModel publication);
}
