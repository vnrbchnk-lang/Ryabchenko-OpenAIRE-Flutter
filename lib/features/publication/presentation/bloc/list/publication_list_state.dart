import 'package:openaire_publications/common/network/load_exception.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';

sealed class PublicationListState {
  const PublicationListState({required this.query});

  final String query;
}

final class PublicationListLoading extends PublicationListState {
  const PublicationListLoading({required super.query});
}

final class PublicationListLoaded extends PublicationListState {
  const PublicationListLoaded({required super.query, required this.items});

  final List<PublicationModel> items;
}

final class PublicationListFailure extends PublicationListState {
  const PublicationListFailure({required super.query, required this.error});

  final LoadException error;
}
