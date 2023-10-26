import 'package:dio/dio.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import 'login_helper.dart';
import 'modified_dio_logger.dart';

class _DioHttpClientImpl {
  Dio? _dio;

  Dio of() {
    if (_dio == null) {
      BaseOptions baseOptions = BaseOptions(
        baseUrl: "https://api.masterbagasi.com/v1/mobile/"
      );
      _dio = _ModifiedDio(Dio(baseOptions));
      _dio?.interceptors.add(modifiedDioLoggerInterceptor);
    }

    return _dio ?? (throw Error());
  }
}

class _DioHttpClientOptionsImpl {
  Map<String, dynamic> createTokenHeader(String tokenWithBearer) {
    return <String, dynamic> {
      if (!tokenWithBearer.isEmptyString) "Authorization": tokenWithBearer,
      "Accept": "application/json"
    };
  }

  Options createOptionsWithTokenHeader(String tokenWithBearer) {
    return ExtendedOptions(headers: createTokenHeader(tokenWithBearer));
  }
}

class _ModifiedDio implements Dio {
  final Dio _wrappedDio;
  bool _closed = false;

  _ModifiedDio(this._wrappedDio);

  Options get _optionsWithTokenHeader => DioHttpClientOptions.createOptionsWithTokenHeader(LoginHelper.getTokenWithBearer().result);

  @override
  HttpClientAdapter get httpClientAdapter => _wrappedDio.httpClientAdapter;

  @override
  set httpClientAdapter(HttpClientAdapter value) => _wrappedDio.httpClientAdapter = value;

  @override
  BaseOptions get options => _wrappedDio.options;

  @override
  set options(BaseOptions value) => _wrappedDio.options = value;

  @override
  Interceptors get interceptors => _wrappedDio.interceptors;

  @override
  Transformer get transformer => _wrappedDio.transformer;

  @override
  set transformer(Transformer value) => _wrappedDio.transformer = value;

  @override
  void clear() => _wrappedDio.clear();

  @override
  void close({bool force = false}) {
    _closed = true;
    _wrappedDio.close(force: force);
  }

  @override
  Future<Response<T>> delete<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken})
  => _wrappedDio.delete(path, data: data, queryParameters: queryParameters, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken);

  @override
  Future<Response<T>> deleteUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken})
  => _wrappedDio.deleteUri(uri, data: data, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken);

  @override
  Future<Response> download(String urlPath, savePath, {ProgressCallback? onReceiveProgress, Map<String, dynamic>? queryParameters, CancelToken? cancelToken, bool deleteOnError = true, String lengthHeader = Headers.contentLengthHeader, data, Options? options})
  => _wrappedDio.download(urlPath, savePath, onReceiveProgress: onReceiveProgress, queryParameters: queryParameters, cancelToken: cancelToken, deleteOnError: deleteOnError, lengthHeader: lengthHeader, data: data, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false));

  @override
  Future<Response> downloadUri(Uri uri, savePath, {ProgressCallback? onReceiveProgress, CancelToken? cancelToken, bool deleteOnError = true, String lengthHeader = Headers.contentLengthHeader, data, Options? options})
  => _wrappedDio.downloadUri(uri, savePath, onReceiveProgress: onReceiveProgress, cancelToken: cancelToken, deleteOnError: deleteOnError, lengthHeader: lengthHeader, data: data, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false));

  @override
  Future<Response<T>> fetch<T>(RequestOptions requestOptions) => _wrappedDio.fetch(requestOptions);

  @override
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress})
  => _wrappedDio.get(path, queryParameters: queryParameters, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> getUri<T>(Uri uri, {Options? options, CancelToken? cancelToken, ProgressCallback? onReceiveProgress})
  => _wrappedDio.getUri(uri, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> head<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken})
  => _wrappedDio.head(path, data: data, queryParameters: queryParameters, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken);

  @override
  Future<Response<T>> headUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken})
  => _wrappedDio.headUri(uri, data: data, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken);

  @override
  void lock() => _wrappedDio.lock();

  @override
  Future<Response<T>> patch<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress})
  => _wrappedDio.patch(path, data: data, queryParameters: queryParameters, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> patchUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress})
  => _wrappedDio.patchUri(uri, data: data, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> post<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress})
  => _wrappedDio.post(path, data: data, queryParameters: queryParameters, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> postUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress})
  => _wrappedDio.postUri(uri, data: data, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> put<T>(String path, {data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress})
  => _wrappedDio.put(path, data: data, queryParameters: queryParameters, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> putUri<T>(Uri uri, {data, Options? options, CancelToken? cancelToken, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress})
  => _wrappedDio.putUri(uri, data: data, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> request<T>(String path, {data, Map<String, dynamic>? queryParameters, CancelToken? cancelToken, Options? options, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress})
  => _wrappedDio.request(path, data: data, queryParameters: queryParameters, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);

  @override
  Future<Response<T>> requestUri<T>(Uri uri, {data, CancelToken? cancelToken, Options? options, ProgressCallback? onSendProgress, ProgressCallback? onReceiveProgress})
  => _wrappedDio.requestUri(uri, data: data, options: _optionsWithTokenHeader.merge(options, allowHeadersMerging: false), cancelToken: cancelToken, onSendProgress: onSendProgress, onReceiveProgress: onReceiveProgress);

  @override
  void unlock() => _wrappedDio.unlock();
}

// ignore: non_constant_identifier_names
final DioHttpClient = _DioHttpClientImpl();

// ignore: non_constant_identifier_names
final DioHttpClientOptions = _DioHttpClientOptionsImpl();

extension on Options {
  Options merge(
    Options? options, {
    bool allowBaseUrlMerging = true,
    bool allowMethodMerging = true,
    bool allowSendTimeoutMerging = true,
    bool allowReceiveTimeoutMerging = true,
    bool allowExtraMerging = true,
    bool allowHeadersMerging = true,
    bool allowResponseTypeMerging = true,
    bool allowContentTypeMerging = true,
    bool allowValidateStatusMerging = true,
    bool allowReceiveDataWhenStatusErrorMerging = true,
    bool allowFollowRedirectsMethodMerging = true,
    bool allowMaxRedirectsMerging = true,
    bool allowRequestEncoderMerging = true,
    bool allowResponseDecoderMerging = true,
    bool allowListFormatMerging = true,
  }) {
    if (options == null) {
      return this;
    }
    if (this is ExtendedOptions) {
      return (this as ExtendedOptions).copyWith(
        baseUrl: options is ExtendedOptions ? (allowBaseUrlMerging ? options.baseUrl : null) : null,
        method: allowMethodMerging ? options.method : null,
        sendTimeout: allowSendTimeoutMerging ? options.sendTimeout : null,
        receiveTimeout: allowReceiveTimeoutMerging ? options.receiveTimeout : null,
        extra: allowExtraMerging ? options.extra : null,
        headers: allowHeadersMerging ? options.headers : null,
        responseType: allowResponseTypeMerging ? options.responseType : null,
        contentType: allowContentTypeMerging ? options.contentType : null,
        validateStatus: allowValidateStatusMerging ? options.validateStatus : null,
        receiveDataWhenStatusError: allowReceiveDataWhenStatusErrorMerging ? options.receiveDataWhenStatusError : null,
        followRedirects: allowFollowRedirectsMethodMerging ? options.followRedirects : null,
        maxRedirects: allowMaxRedirectsMerging ? options.maxRedirects : null,
        requestEncoder: allowRequestEncoderMerging ? options.requestEncoder : null,
        responseDecoder: allowResponseDecoderMerging ? options.responseDecoder : null,
        listFormat: allowListFormatMerging ? options.listFormat : null
      );
    } else {
      return copyWith(
        method: allowMethodMerging ? options.method : null,
        sendTimeout: allowSendTimeoutMerging ? options.sendTimeout : null,
        receiveTimeout: allowReceiveTimeoutMerging ? options.receiveTimeout : null,
        extra: allowExtraMerging ? options.extra : null,
        headers: allowHeadersMerging ? options.headers : null,
        responseType: allowResponseTypeMerging ? options.responseType : null,
        contentType: allowContentTypeMerging ? options.contentType : null,
        validateStatus: allowValidateStatusMerging ? options.validateStatus : null,
        receiveDataWhenStatusError: allowReceiveDataWhenStatusErrorMerging ? options.receiveDataWhenStatusError : null,
        followRedirects: allowFollowRedirectsMethodMerging ? options.followRedirects : null,
        maxRedirects: allowMaxRedirectsMerging ? options.maxRedirects : null,
        requestEncoder: allowRequestEncoderMerging ? options.requestEncoder : null,
        responseDecoder: allowResponseDecoderMerging ? options.responseDecoder : null,
        listFormat: allowListFormatMerging ? options.listFormat : null
      );
    }
  }
}

class ExtendedOptions extends Options {
  late Options _wrappedOptions;
  String? baseUrl;

  @override
  String? get method => _wrappedOptions.method;

  @override
  set method(String? value) => _wrappedOptions.method = value;

  @override
  Map<String, dynamic>? get headers => _wrappedOptions.headers;

  @override
  set headers(Map<String, dynamic>? value) => _wrappedOptions.headers = value;

  @override
  int? get sendTimeout => _wrappedOptions.sendTimeout;

  @override
  set sendTimeout(int? value) => _wrappedOptions.sendTimeout = value;

  @override
  int? get receiveTimeout => _wrappedOptions.receiveTimeout;

  @override
  set receiveTimeout(int? value) => _wrappedOptions.receiveTimeout = value;

  @override
  String? get contentType => _wrappedOptions.contentType;

  @override
  set contentType(String? value) => _wrappedOptions.contentType = value;

  @override
  ResponseType? get responseType => _wrappedOptions.responseType;

  @override
  set responseType(ResponseType? value) => _wrappedOptions.responseType = value;

  @override
  ValidateStatus? get validateStatus => _wrappedOptions.validateStatus;

  @override
  set validateStatus(ValidateStatus? value) => _wrappedOptions.validateStatus = value;

  @override
  bool? get receiveDataWhenStatusError => _wrappedOptions.receiveDataWhenStatusError;

  @override
  set receiveDataWhenStatusError(bool? value) => _wrappedOptions.receiveDataWhenStatusError = value;

  @override
  Map<String, dynamic>? get extra => _wrappedOptions.extra;

  @override
  set extra(Map<String, dynamic>? value) => _wrappedOptions.extra = value;

  @override
  bool? get followRedirects => _wrappedOptions.followRedirects;

  @override
  set followRedirects(bool? value) => _wrappedOptions.followRedirects = value;

  @override
  int? get maxRedirects => _wrappedOptions.maxRedirects;

  @override
  set maxRedirects(int? value) => _wrappedOptions.maxRedirects = value;

  @override
  RequestEncoder? get requestEncoder => _wrappedOptions.requestEncoder;

  @override
  set requestEncoder(RequestEncoder? value) => _wrappedOptions.requestEncoder = value;

  @override
  ResponseDecoder? get responseDecoder => _wrappedOptions.responseDecoder;

  @override
  set responseDecoder(ResponseDecoder? value) => _wrappedOptions.responseDecoder = value;

  @override
  ListFormat? get listFormat => _wrappedOptions.listFormat;

  @override
  set listFormat(ListFormat? value) => _wrappedOptions.listFormat = value;

  ExtendedOptions({
    this.baseUrl,
    String? method,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
    String? contentType,
    ValidateStatus? validateStatus,
    bool? receiveDataWhenStatusError,
    bool? followRedirects,
    int? maxRedirects,
    RequestEncoder? requestEncoder,
    ResponseDecoder? responseDecoder,
    ListFormat? listFormat,
  }) {
    _wrappedOptions = Options(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      extra: extra,
      headers: headers,
      responseType: responseType,
      contentType: contentType,
      validateStatus: validateStatus,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      listFormat: listFormat,
    );
  }

  ExtendedOptions._fromOptions(Options options) {
    _wrappedOptions = options;
  }

  @override
  ExtendedOptions copyWith({
    String? baseUrl,
    String? method,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
    ResponseType? responseType,
    String? contentType,
    ValidateStatus? validateStatus,
    bool? receiveDataWhenStatusError,
    bool? followRedirects,
    int? maxRedirects,
    RequestEncoder? requestEncoder,
    ResponseDecoder? responseDecoder,
    ListFormat? listFormat,
  }) {
    return ExtendedOptions._fromOptions(
      _wrappedOptions.copyWith(
        method: method ?? this.method,
        sendTimeout: sendTimeout ?? this.sendTimeout,
        receiveTimeout: receiveTimeout ?? this.receiveTimeout,
        extra: extra ?? this.extra,
        headers: headers ?? this.headers,
        responseType: responseType ?? this.responseType,
        contentType: contentType ?? this.contentType,
        validateStatus: validateStatus ?? this.validateStatus,
        receiveDataWhenStatusError: receiveDataWhenStatusError ?? this.receiveDataWhenStatusError,
        followRedirects: followRedirects ?? this.followRedirects,
        maxRedirects: maxRedirects ?? this.maxRedirects,
        requestEncoder: requestEncoder ?? this.requestEncoder,
        responseDecoder: responseDecoder ?? this.responseDecoder,
        listFormat: listFormat ?? this.listFormat
      )
    )..baseUrl = baseUrl ?? this.baseUrl;
  }

  @override
  RequestOptions compose(
    BaseOptions baseOpt,
    String path, {
      data,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      Options? options,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }
  ) {
    RequestOptions requestOptions = super.compose(
      baseOpt,
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    if (baseUrl != null) {
      requestOptions.baseUrl = baseUrl!;
    }
    return requestOptions;
  }
}