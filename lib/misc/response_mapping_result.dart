class ResponseMappingResult<T> {
  T? result;
  bool isMapped;

  ResponseMappingResult({
    required this.result,
    required this.isMapped
  });
}