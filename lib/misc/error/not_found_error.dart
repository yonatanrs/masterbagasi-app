class NotFoundError extends Error {
  final String message;

  NotFoundError({this.message = ""});

  @override
  String toString() {
    return 'NotFoundError: $message';
  }
}