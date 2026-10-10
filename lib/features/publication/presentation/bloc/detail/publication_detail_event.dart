sealed class PublicationDetailEvent {
  const PublicationDetailEvent();
}

final class PublicationDetailOpened extends PublicationDetailEvent {
  const PublicationDetailOpened(this.id);

  final String id;
}
