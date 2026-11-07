import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:openaire_publications/common/navigation/app_router.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';

class RelatedList extends StatelessWidget {
  const RelatedList({super.key, required this.publications});

  final List<PublicationModel> publications;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final publication in publications)
          InkWell(
            onTap: () => context.push(AppRoutes.detail(publication.id)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                publication.mainTitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
