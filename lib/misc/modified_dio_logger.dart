import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final modifiedDioLoggerInterceptor = InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
  String headers = "";
  options.headers.forEach((key, value) {
    headers += "| $key: $value";
  });
  if (kDebugMode) {
    late dynamic dataMap;
    if (options.data is FormData) {
      dataMap = (options.data as FormData).fields.asMap().map<String, dynamic>((key, value) => value);
    } else {
      dataMap = options.data;
    }
    print("┌------------------------------------------------------------------------------");
    print('''| [DIO] Request: ${options.method} ${options.uri}
| $dataMap
| Headers:\n$headers''');
    print("├------------------------------------------------------------------------------");
  }
  handler.next(options);  //continue
}, onResponse: (Response response, handler) async {
  if (kDebugMode) {
    print("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
    print("└------------------------------------------------------------------------------");
  }
  handler.next(response);
  // return response; // continue
}, onError: (DioError error, handler) async {
  if (kDebugMode) {
    print("| [DIO] Error: ${error.error}: ${error.response.toString()}");
    print("└------------------------------------------------------------------------------");
  }
  handler.next(error); //continue
});
