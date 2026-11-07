// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationDto _$PublicationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PublicationDto', json, ($checkedConvert) {
      final val = PublicationDto(
        id: $checkedConvert('id', (v) => v as String),
        mainTitle: $checkedConvert('mainTitle', (v) => v as String),
        type: $checkedConvert('type', (v) => v as String),
        authors: $checkedConvert(
          'authors',
          (v) => (v as List<dynamic>?)
              ?.map((e) => AuthorDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        publicationDate: $checkedConvert(
          'publicationDate',
          (v) => v as String?,
        ),
        descriptions: $checkedConvert(
          'descriptions',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        subjects: $checkedConvert(
          'subjects',
          (v) => (v as List<dynamic>?)
              ?.map((e) => SubjectDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        publisher: $checkedConvert('publisher', (v) => v as String?),
      );
      return val;
    });

AuthorDto _$AuthorDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthorDto', json, ($checkedConvert) {
      final val = AuthorDto(
        fullName: $checkedConvert('fullName', (v) => v as String?),
      );
      return val;
    });

SubjectDto _$SubjectDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SubjectDto', json, ($checkedConvert) {
      final val = SubjectDto(
        subject: $checkedConvert(
          'subject',
          (v) => SubjectValueDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

SubjectValueDto _$SubjectValueDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SubjectValueDto', json, ($checkedConvert) {
      final val = SubjectValueDto(
        value: $checkedConvert('value', (v) => v as String),
      );
      return val;
    });
