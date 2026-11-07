import 'package:openaire_publications/features/publication/data/dto/publication_dto.dart';
import 'package:openaire_publications/features/publication/data/dto/publication_page_dto.dart';

abstract interface class IPublicationDataSource {
  Future<PublicationPageDto> getPublicationPage({
    required int page,
    required int pageSize,
    String? title,
    String? subject,
  });

  Future<PublicationDto> getPublication(String id);
}
