import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/widgets/app_scaffold.dart';
import 'package:openaire_publications/features/publication/domain/i_publication_repository.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/detail/publication_detail_bloc.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/detail/publication_detail_event.dart';
import 'package:openaire_publications/features/publication/presentation/bloc/detail/publication_detail_state.dart';
import 'package:openaire_publications/features/publication/presentation/utils/publication_format.dart';
import 'package:openaire_publications/features/publication/presentation/view/widgets/detail_field.dart';
import 'package:openaire_publications/features/publication/presentation/view/widgets/related_list.dart';
import 'package:openaire_publications/l10n/app_localizations.dart';

class PublicationDetailScreen extends StatelessWidget {
  const PublicationDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PublicationDetailBloc(context.read<IPublicationRepository>())
            ..add(PublicationDetailOpened(id)),
      child: AppScaffold(
        body: BlocBuilder<PublicationDetailBloc, PublicationDetailState>(
          builder: (context, state) => switch (state) {
            PublicationDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            PublicationDetailNotFound(:final id) => Center(
              child: Text(AppLocalizations.of(context).detailNotFound(id)),
            ),
            PublicationDetailLoaded(:final publication, :final related) =>
              _DetailContent(publication: publication, related: related),
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.publication, required this.related});

  final PublicationModel publication;
  final List<PublicationModel> related;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Text(publication.mainTitle, style: theme.textTheme.headlineSmall),
              DetailField(
                label: l10n.detailAuthors,
                value: publication.authorsLine,
              ),
              DetailField(
                label: l10n.detailPublicationDate,
                value: publication.publicationDate,
              ),
              DetailField(
                label: l10n.detailPublisher,
                value: publication.publisher,
              ),
              DetailField(label: l10n.detailType, value: publication.type),
              DetailField(
                label: l10n.detailSubjects,
                value: publication.subjectsLine,
              ),
              Text(publication.description, style: theme.textTheme.bodyLarge),
              if (related.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(l10n.detailRelated, style: theme.textTheme.titleMedium),
                RelatedList(publications: related),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
