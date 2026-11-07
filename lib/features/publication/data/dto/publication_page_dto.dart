import 'package:json_annotation/json_annotation.dart';
import 'package:openaire_publications/features/publication/data/dto/publication_dto.dart';

part 'publication_page_dto.g.dart';

@JsonSerializable()
class PublicationPageDto {
  const PublicationPageDto({required this.results});

  factory PublicationPageDto.fromJson(Map<String, dynamic> json) =>
      _$PublicationPageDtoFromJson(json);

  final List<PublicationDto> results;
}
