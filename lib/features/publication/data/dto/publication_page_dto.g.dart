// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication_page_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicationPageDto _$PublicationPageDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PublicationPageDto', json, ($checkedConvert) {
      final val = PublicationPageDto(
        results: $checkedConvert(
          'results',
          (v) => (v as List<dynamic>)
              .map((e) => PublicationDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });
