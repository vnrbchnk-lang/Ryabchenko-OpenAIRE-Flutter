import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openaire_publications/common/widgets/app_scaffold.dart';
import 'package:openaire_publications/features/publication/domain/i_publication_repository.dart';
import 'package:openaire_publications/features/publication/domain/publication_details_model.dart';
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
            PublicationDetailLoaded(:final details) => _DetailContent(
              details: details,
            ),
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.details});

  final PublicationDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final publication = details.publication;
    final publicationDate = publication.publicationDate;
    final publisher = publication.publisher;
    final description = publication.description;
    final related = details.related;
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
              if (publication.authors.isNotEmpty)
                DetailField(
                  label: l10n.detailAuthors,
                  value: publication.authorsLine,
                ),
              if (publicationDate != null)
                DetailField(
                  label: l10n.detailPublicationDate,
                  value: publicationDate,
                ),
              if (publisher != null)
                DetailField(label: l10n.detailPublisher, value: publisher),
              DetailField(label: l10n.detailType, value: publication.type),
              if (publication.subjects.isNotEmpty)
                DetailField(
                  label: l10n.detailSubjects,
                  value: publication.subjectsLine,
                ),
              if (description != null)
                Text(description, style: theme.textTheme.bodyLarge),
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
