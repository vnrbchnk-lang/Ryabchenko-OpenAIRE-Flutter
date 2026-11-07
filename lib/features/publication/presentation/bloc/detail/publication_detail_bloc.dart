import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/network/load_exception.dart';
import 'package:openaire_publications/features/publication/domain/i_publication_repository.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/detail/publication_detail_event.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/detail/publication_detail_state.dart';

class PublicationDetailBloc
    extends Bloc<PublicationDetailEvent, PublicationDetailState> {
  PublicationDetailBloc(this._repository)
    : super(const PublicationDetailLoading()) {
    on<PublicationDetailOpened>(_onOpened);
  }

  final IPublicationRepository _repository;

  Future<void> _onOpened(
    PublicationDetailOpened event,
    Emitter<PublicationDetailState> emit,
  ) async {
    try {
      final details = await _repository.getDetails(event.id);
      emit(PublicationDetailLoaded(details));
    } on NotFoundException {
      emit(PublicationDetailNotFound(event.id));
    }
  }
}
