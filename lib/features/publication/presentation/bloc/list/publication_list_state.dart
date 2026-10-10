import 'package:openaire_publications/features/publication/domain/publication_model.dart';

sealed class PublicationListState {
  const PublicationListState();
}

final class PublicationListLoading extends PublicationListState {
  const PublicationListLoading();
}

final class PublicationListLoaded extends PublicationListState {
  const PublicationListLoaded({required this.query, required this.items});

  final String query;
  final List<PublicationModel> items;
}
