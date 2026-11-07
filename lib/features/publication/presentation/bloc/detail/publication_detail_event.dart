sealed class PublicationDetailEvent {
  const PublicationDetailEvent(this.id);

  final String id;
}

final class PublicationDetailOpened extends PublicationDetailEvent {
  const PublicationDetailOpened(super.id);
}

final class PublicationDetailRetried extends PublicationDetailEvent {
  const PublicationDetailRetried(super.id);
}
