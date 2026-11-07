import 'package:flutter/material.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';
import 'package:openaire_publications/features/publication/presentation/utils/publication_format.dart';

class PublicationPlaceholder extends StatelessWidget {
  const PublicationPlaceholder({super.key, required this.publication});

  final PublicationModel publication;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(publication.typeIcon, color: colors.onSecondaryContainer),
    );
  }
}
