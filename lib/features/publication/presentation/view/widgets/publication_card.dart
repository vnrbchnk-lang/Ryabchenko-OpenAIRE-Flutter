import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openaire_publications/common/navigation/app_router.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';
import 'package:openaire_publications/features/publication/presentation/utils/publication_format.dart';
import 'package:openaire_publications/features/publication/presentation/view/widgets/publication_placeholder.dart';

class PublicationCard extends StatelessWidget {
  const PublicationCard({super.key, required this.publication});

  final PublicationModel publication;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.detail(publication.id)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              PublicationPlaceholder(publication: publication),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      publication.mainTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      publication.authorsLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      publication.publicationDate,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
