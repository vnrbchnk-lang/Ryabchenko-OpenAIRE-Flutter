import 'package:openaire_publications/features/publication/domain/publication_model.dart';

final class PublicationDetailsModel {
  const PublicationDetailsModel({
    required this.publication,
    required this.related,
  });

  final PublicationModel publication;
  final List<PublicationModel> related;
}
