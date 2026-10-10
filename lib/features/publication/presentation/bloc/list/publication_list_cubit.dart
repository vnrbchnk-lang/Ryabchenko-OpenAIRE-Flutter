import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/features/publication/domain/i_publication_repository.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/list/publication_list_state.dart';

class PublicationListCubit extends Cubit<PublicationListState> {
  PublicationListCubit(this._repository)
    : super(const PublicationListLoading());

  final IPublicationRepository _repository;

  Future<void> load() async {
    final items = await _repository.getPublications();
    if (isClosed) return;
    emit(PublicationListLoaded(query: '', items: items));
  }
}
