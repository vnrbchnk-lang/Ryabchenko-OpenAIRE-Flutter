final class PublicationModel {
  const PublicationModel({
    required this.id,
    required this.mainTitle,
    required this.authors,
    required this.publicationDate,
    required this.description,
    required this.subjects,
    required this.type,
    required this.publisher,
  });

  final String id;
  final String mainTitle;
  final List<String> authors;
  final String publicationDate;
  final String description;
  final List<String> subjects;
  final String type;
  final String publisher;
}
