import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/network/load_exception.dart';
import 'package:openaire_publications/features/publication/domain/i_publication_repository.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/list/publication_list_state.dart';

class PublicationListCubit extends Cubit<PublicationListState> {
  PublicationListCubit(this._repository)
    : super(const PublicationListLoading(query: ''));

  final IPublicationRepository _repository;

  static const int _pageSize = 20;

  static const Duration _searchDelay = Duration(milliseconds: 400);

  Timer? _searchTimer;

  Future<void> load() => _load('');

  Future<void> retry() => _load(state.query);

  void search(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(_searchDelay, () => _load(query.trim()));
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! PublicationListLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }
    emit(
      PublicationListLoaded(
        query: current.query,
        items: current.items,
        hasMore: true,
        isLoadingMore: true,
      ),
    );
    try {
      final next = await _repository.getPublications(
        page: current.items.length ~/ _pageSize + 1,
        pageSize: _pageSize,
      );
      if (isClosed || state.query != current.query) return;
      emit(
        PublicationListLoaded(
          query: current.query,
          items: [...current.items, ...next],
          hasMore: next.length == _pageSize,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || state.query != current.query) return;
      emit(
        PublicationListLoaded(
          query: current.query,
          items: current.items,
          hasMore: true,
          loadMoreError: error,
        ),
      );
    }
  }

  Future<void> _load(String query) async {
    emit(PublicationListLoading(query: query));
    try {
      final items = query.isEmpty
          ? await _repository.getPublications(page: 1, pageSize: _pageSize)
          : await _repository.searchPublications(query);
      if (isClosed || state.query != query) return;
      emit(
        PublicationListLoaded(
          query: query,
          items: items,
          hasMore: query.isEmpty && items.length == _pageSize,
        ),
      );
    } on LoadException catch (error) {
      if (isClosed || state.query != query) return;
      emit(PublicationListFailure(query: query, error: error));
    }
  }

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }
}
