import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../auth/sign_in/hive/token_storage.dart';

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
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
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
                // Assuming the new access token is in the response data
                final newAccessToken = refreshResponse.data['accessToken'];
                final newRefreshToken = refreshResponse.data['refreshToken'];

                // Save the new tokens
                await TokenStorage.saveTokens(newAccessToken, newRefreshToken);

                // Retry the original request with the new token
                final options = e.response?.requestOptions;
                options?.headers['Authorization'] = 'Bearer $newAccessToken';

                // Create a new Options object
                final retryOptions = Options(
                  method: options?.method,
                  headers: options?.headers,
                );

                final retryResponse = await _dio.request(
                  options!.path,
                  options: retryOptions,
                );
                return handler.resolve(retryResponse);
              }
            } catch (refreshError) {
              // Handle refresh token error (optional)
            }
          }
        }
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
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    try {
      return await _dio.delete(
        path,
        queryParameters: params,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async {
    try {
      return await _dio.put(
        path,
        queryParameters: params,
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
