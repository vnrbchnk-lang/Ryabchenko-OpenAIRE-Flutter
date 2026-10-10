import 'package:openaire_publications/features/publication/domain/publication_model.dart';

sealed class PublicationDetailState {
  const PublicationDetailState();
}

final class PublicationDetailLoading extends PublicationDetailState {
  const PublicationDetailLoading();
}

final class PublicationDetailLoaded extends PublicationDetailState {
  const PublicationDetailLoaded(this.publication, {required this.related});

  final PublicationModel publication;
  final List<PublicationModel> related;
}

final class PublicationDetailNotFound extends PublicationDetailState {
  const PublicationDetailNotFound(this.id);

  final String id;
}
