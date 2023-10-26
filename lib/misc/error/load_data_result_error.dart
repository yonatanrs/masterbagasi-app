class LoadDataResultError extends Error {
  final String message;

  LoadDataResultError({this.message = ""});

  @override
  String toString() {
    return 'LoadDataResultError: $message';
  }
}