import 'dart:developer'; // For log()
import 'package:dio/dio.dart';

class ManualDioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      '➡️ REQUEST [${options.method}] => URL: ${options.uri}',
      name: 'DIO',
    );
    log('Headers: ${options.headers}', name: 'DIO');
    log('QueryParameters: ${options.queryParameters}', name: 'DIO');
    log('Data: ${options.data}', name: 'DIO');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      '✅ RESPONSE [${response.statusCode}] => URL: ${response.requestOptions.uri}',
      name: 'DIO',
    );
    log('Response Data: ${response.data}', name: 'DIO');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
      '❌ ERROR [${err.response?.statusCode}] => URL: ${err.requestOptions.uri}',
      name: 'DIO',
      error: err,
      stackTrace: err.stackTrace,
    );
    log('Error Message: ${err.message}', name: 'DIO');
    if (err.response != null) {
      log('Error Data: ${err.response?.data}', name: 'DIO');
    }
    super.onError(err, handler);
  }
}
