import 'package:openaire_publications/features/publication/data/dto/publication_dto.dart';
import 'package:openaire_publications/features/publication/domain/publication_model.dart';

extension PublicationDtoMapper on PublicationDto {
  PublicationModel toModel() => PublicationModel(
    id: id,
    mainTitle: _plainText(mainTitle) ?? mainTitle,
    authors: [
      for (final author in authors ?? const <AuthorDto>[])
        ?_name(author.fullName),
    ],
    publicationDate: publicationDate,
    description: _plainText(descriptions?.firstOrNull),
    subjects: [
      for (final subject in subjects ?? const <SubjectDto>[])
        subject.subject.value,
    ],
    type: type,
    publisher: publisher,
  );
}

String? _name(String? fullName) {
  final name = fullName?.replaceAll(RegExp(r'^[\s,]+|[\s,]+$'), '');
  return name == null || name.isEmpty ? null : name;
}

String? _plainText(String? markup) {
  if (markup == null) return null;
  final text = markup
      .replaceAll(RegExp(r'<[^>]*>'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  return text.isEmpty ? null : text;
}
