import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpService {
  final Dio _dio;

  HttpService(String baseUrl)
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('🟢 Requisição: ${options.method} ${options.uri}');
          }
          if (options.headers.containsKey('Authorization')) {
            if (kDebugMode) {
              print('🔑 Token: ${options.headers['Authorization']}');
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('🟢 Resposta [${response.statusCode}]: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('🔴 Erro: ${e.message}');
          }
          if (e.response != null) {
            if (kDebugMode) {
              print('🔴 Detalhes do Erro: ${e.response?.data}');
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    if (e.response != null) {
      if (kDebugMode) {
        print('Erro: ${e.response?.statusCode} - ${e.response?.data}');
      }
    } else {
      if (kDebugMode) {
        print('Erro de conexão: ${e.message}');
      }
    }
  }
}
