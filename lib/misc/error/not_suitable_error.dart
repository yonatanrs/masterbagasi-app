class NotSuitableError extends Error {
  final String message;

  NotSuitableError({this.message = ""});

  @override
  String toString() {
    return 'NotSuitableError: $message';
  }
}