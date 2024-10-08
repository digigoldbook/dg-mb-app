import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../auth/sign_in/hive/token_storage.dart';

class HttpService {
  final Dio _dio = Dio();
  String url = dotenv.env['URL'] ?? '';

  HttpService() {
    _dio.options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await TokenStorage.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('Response received: ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        // Check if the error is 401 Unauthorized
        if (e.response?.statusCode == 403) {
          final refreshToken = await TokenStorage.getRefreshToken();
          if (refreshToken != null) {
            try {
              // Attempt to refresh the token
              final refreshResponse = await _dio.post(
                '/auth/verify-token',
                data: {
                  'refreshToken': refreshToken,
                },
              );

              if (refreshResponse.statusCode == 200) {
                // If refresh is successful, save the new access token
                final newAccessToken = refreshResponse.data['accessToken'];
                await TokenStorage.saveTokens(newAccessToken, refreshToken);

                // Retry the original request with the new access token
                final options = e.response?.requestOptions;
                if (options != null) {
                  options.headers['Authorization'] = 'Bearer $newAccessToken';

                  // Create a new request with the updated headers and original options
                  final retryResponse = await _dio.request(
                    options.path,
                    options: Options(
                      method: options.method,
                      headers: options.headers,
                      responseType: options.responseType,
                      contentType: options.contentType,
                      followRedirects: options.followRedirects,
                      validateStatus: options.validateStatus,
                      receiveDataWhenStatusError:
                          options.receiveDataWhenStatusError,
                    ),
                    data: options.data,
                    queryParameters: options.queryParameters,
                  );

                  // Resolve the handler with the retry response
                  return handler.resolve(retryResponse);
                }
              }
            } catch (refreshError) {
              debugPrint('Token refresh failed: $refreshError');
              return handler.reject(e);
            }
          }
        }
        debugPrint('Error occurred: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      debugPrint('GET request failed: $e');
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      debugPrint(path + data.toString());
      return await _dio.post(path, data: data);
    } catch (e) {
      debugPrint('POST request failed: $e');
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    try {
      return await _dio.delete(path, queryParameters: params);
    } catch (e) {
      debugPrint('DELETE request failed: $e');
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.put(path, queryParameters: params, data: data);
    } catch (e) {
      debugPrint('PUT request failed: $e');
      rethrow;
    }
  }
}
