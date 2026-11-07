import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/widgets/app_scaffold.dart';
import 'package:openaire_publications/common/widgets/load_error_view.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/list/publication_list_cubit.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/list/publication_list_state.dart';
import 'package:openaire_publications/features/publication/presentation/view/widgets/publication_card.dart';
import 'package:openaire_publications/features/publication/presentation/view/widgets/search_field.dart';
import 'package:openaire_publications/l10n/app_localizations.dart';

class PublicationListScreen extends StatelessWidget {
  const PublicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PublicationListCubit>();
    return AppScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: SearchField(onChanged: cubit.search),
          ),
          Expanded(
            child: BlocBuilder<PublicationListCubit, PublicationListState>(
              builder: (context, state) => switch (state) {
                PublicationListLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                PublicationListFailure(:final error) => Center(
                  child: LoadErrorView(error: error, onRetry: cubit.retry),
                ),
                PublicationListLoaded(:final query, :final items)
                    when items.isEmpty && query.isEmpty =>
                  Center(child: Text(AppLocalizations.of(context).listEmpty)),
                PublicationListLoaded(:final query, :final items)
                    when items.isEmpty =>
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        AppLocalizations.of(context).nothingFound(query),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                PublicationListLoaded() => _PublicationList(state: state),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PublicationList extends StatefulWidget {
  const _PublicationList({required this.state});

  final PublicationListLoaded state;

  @override
  State<_PublicationList> createState() => _PublicationListState();
}

class _PublicationListState extends State<_PublicationList> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.extentAfter < 240) {
      context.read<PublicationListCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final showFooter = state.isLoadingMore || state.loadMoreError != null;
    return ListView.separated(
      controller: _controller,
      padding: const EdgeInsets.all(16),
      itemCount: state.items.length + (showFooter ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => index < state.items.length
          ? PublicationCard(publication: state.items[index])
          : _Footer(state: state),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.state});

  final PublicationListLoaded state;

  @override
  Widget build(BuildContext context) {
    final error = state.loadMoreError;
    return Center(
      child: error == null
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          : LoadErrorView(
              error: error,
              onRetry: context.read<PublicationListCubit>().loadMore,
            ),
    );
  }
}
