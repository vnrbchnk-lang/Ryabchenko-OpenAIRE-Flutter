import 'package:json_annotation/json_annotation.dart';

part 'publication_dto.g.dart';

@JsonSerializable()
class PublicationDto {
  const PublicationDto({
    required this.id,
    required this.mainTitle,
    required this.type,
    this.authors,
    this.publicationDate,
    this.descriptions,
    this.subjects,
    this.publisher,
  });

  factory PublicationDto.fromJson(Map<String, dynamic> json) =>
      _$PublicationDtoFromJson(json);

  final String id;
  final String mainTitle;
  final String type;
  final List<AuthorDto>? authors;
  final String? publicationDate;
  final List<String>? descriptions;
  final List<SubjectDto>? subjects;
  final String? publisher;
}

@JsonSerializable()
class AuthorDto {
  const AuthorDto({this.fullName});

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);

  final String? fullName;
}

@JsonSerializable()
class SubjectDto {
  const SubjectDto({required this.subject});

  factory SubjectDto.fromJson(Map<String, dynamic> json) =>
      _$SubjectDtoFromJson(json);

  final SubjectValueDto subject;
}

@JsonSerializable()
class SubjectValueDto {
  const SubjectValueDto({required this.value});

  factory SubjectValueDto.fromJson(Map<String, dynamic> json) =>
      _$SubjectValueDtoFromJson(json);

  final String value;
}
