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
  const PublicationListLoaded({
    required super.query,
    required this.items,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<PublicationModel> items;
  final bool hasMore;
  final bool isLoadingMore;
  final LoadException? loadMoreError;
}

final class PublicationListFailure extends PublicationListState {
  const PublicationListFailure({required super.query, required this.error});

  final LoadException error;
}
