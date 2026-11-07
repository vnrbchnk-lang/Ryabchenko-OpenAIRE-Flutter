import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract final class DioClient {
  static const String baseUrl = 'https://api.openaire.eu/graph/v1';

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          logPrint: (line) => debugPrint('[dio] $line'),
        ),
      );
    }
    return dio;
  }
}
