class ComingSoonError extends Error {
  final String message;

  ComingSoonError({this.message = ""});

  @override
  String toString() {
    return 'ComingSoonError: $message';
  }
}