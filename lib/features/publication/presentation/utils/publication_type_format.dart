import 'package:flutter/material.dart';
import 'package:openaire_publications/features/publication/domain/publication_type.dart';
import 'package:openaire_publications/l10n/app_localizations.dart';

extension PublicationTypeFormat on PublicationType {
  IconData get icon => switch (this) {
    PublicationType.publication => Icons.article_outlined,
    PublicationType.dataset => Icons.dataset_outlined,
    PublicationType.software => Icons.code,
    PublicationType.other => Icons.description_outlined,
  };

  String label(AppLocalizations l10n) => switch (this) {
    PublicationType.publication => l10n.typePublication,
    PublicationType.dataset => l10n.typeDataset,
    PublicationType.software => l10n.typeSoftware,
    PublicationType.other => l10n.typeOther,
  };
}
