import 'package:openaire_publications/features/publication/domain/publication_model.dart';

extension PublicationFormat on PublicationModel {
  String get authorsLine => authors.join(', ');

  String get subjectsLine => subjects.join(', ');
}
