import 'package:flutter/material.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';

extension PublicationFormat on PublicationModel {
  String get authorsLine => authors.join(', ');

  IconData get typeIcon => switch (type) {
    'data' => Icons.dataset_outlined,
    'software' => Icons.code,
    _ => Icons.article_outlined,
  };
}
