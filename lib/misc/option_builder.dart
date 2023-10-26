import 'package:dio/dio.dart';

import 'http_client.dart';

class OptionsBuilder {
  String? _baseUrl;
  String? _method;
  Map<String, dynamic>? _headers;
  int? _sendTimeout;
  int? _receiveTimeout;
  String? _contentType;
  ResponseType? _responseType;
  ValidateStatus? _validateStatus;
  bool? _receiveDataWhenStatusError;
  Map<String, dynamic>? _extra;
  bool? _followRedirects;
  int? _maxRedirects;
  RequestEncoder? _requestEncoder;
  ResponseDecoder? _responseDecoder;
  ListFormat? _listFormat;

  OptionsBuilder();

  factory OptionsBuilder.multipartData() {
    return OptionsBuilder().withMultipartData();
  }

  factory OptionsBuilder.withBaseUrl(String? baseUrl) {
    return OptionsBuilder().withBaseUrl(baseUrl);
  }

  OptionsBuilder withMultipartData() {
    _method = "multipart/form-data";
    return this;
  }

  OptionsBuilder withBaseUrl(String? baseUrl) {
    _baseUrl = baseUrl;
    return this;
  }

  Options build() {
    return Options(
      method: _method,
      sendTimeout: _sendTimeout,
      receiveTimeout: _receiveTimeout,
      extra: _extra,
      headers: _headers,
      responseType: _responseType,
      contentType: _contentType,
      validateStatus: _validateStatus,
      receiveDataWhenStatusError: _receiveDataWhenStatusError,
      followRedirects: _followRedirects,
      maxRedirects: _maxRedirects,
      requestEncoder: _requestEncoder,
      responseDecoder: _responseDecoder,
      listFormat: _listFormat,
    );
  }

  ExtendedOptions buildExtended() {
    return ExtendedOptions(
      baseUrl: _baseUrl,
      method: _method,
      sendTimeout: _sendTimeout,
      receiveTimeout: _receiveTimeout,
      extra: _extra,
      headers: _headers,
      responseType: _responseType,
      contentType: _contentType,
      validateStatus: _validateStatus,
      receiveDataWhenStatusError: _receiveDataWhenStatusError,
      followRedirects: _followRedirects,
      maxRedirects: _maxRedirects,
      requestEncoder: _requestEncoder,
      responseDecoder: _responseDecoder,
      listFormat: _listFormat,
    );
  }
}