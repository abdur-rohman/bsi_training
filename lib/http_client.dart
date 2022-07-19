import 'package:bsi_training/http_interceptior.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpClient {
  static Dio dio() {
    var dio = Dio();
    dio.options.baseUrl = 'https://reqres.in/api/';
    dio.options.sendTimeout = 30 * 1000;
    dio.options.connectTimeout = 30 * 1000;
    dio.options.receiveTimeout = 30 * 1000;

    if (kDebugMode) dio.interceptors.add(LoggingInterceptor());

    return dio;
  }
}
