import 'package:openaire_publications/features/publication/domain/publication_details_model.dart';

sealed class PublicationDetailState {
  const PublicationDetailState();
}

final class PublicationDetailLoading extends PublicationDetailState {
  const PublicationDetailLoading();
}

final class PublicationDetailLoaded extends PublicationDetailState {
  const PublicationDetailLoaded(this.details);

  final PublicationDetailsModel details;
}

final class PublicationDetailNotFound extends PublicationDetailState {
  const PublicationDetailNotFound(this.id);

  final String id;
}
