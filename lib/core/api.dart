import 'package:dio/dio.dart';
import 'dart:developer';
import 'dart:core';

class XResponse<T> {
  final T? data;
  final String? message;
  final bool success;

  XResponse.success(this.data)
      : success = true,
        message = null;

  XResponse.error(this.message)
      : success = false,
        data = null;
}

class XApi {
  static Dio? _dio;

  static void init({required String baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) => status != null && status < 500,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    ));
  }

  static void addInspector(List<Interceptor> interceptors) {
    if (interceptors.isNotEmpty) {
      _dio!.interceptors.addAll([...interceptors]);
    }
  }

  static Dio get dio {
    if (_dio == null) {
      throw Exception('XApi not initialized. Call XApi.init() first.');
    }
    return _dio!;
  }

  static Future<XResponse<T>> get<T>(String path) async {
    try {
      final res = await dio.get<T>(path);
      log("${res.data}+++-->${res.statusCode}");
      if (res.statusCode != null &&
          res.statusCode! >= 200 &&
          res.statusCode! < 300) {
        return XResponse.success(res.data);
      }

      return XResponse.error(_mapError(res.statusCode));
    } on DioException catch (e) {
      return XResponse.error(_mapDioError(e));
    } catch (_) {
      return XResponse.error("Something went wrong");
    }
  }

  static Future<XResponse<T>> post<T>(String path, {dynamic data}) async {
    try {
      final res = await dio.post<T>(path, data: data); // ✅ FIX
      return XResponse.success(res.data);
      return XResponse.error(_mapError(res.statusCode));
    } on DioException catch (e) {
      return XResponse.error(_mapDioError(e));
    } catch (_) {
      return XResponse.error("Something went wrong");
    }
  }

  static String _mapError(int? code) {
    switch (code) {
      case 401:
        return "Session expired. Please login again.";
      case 403:
        return "You don’t have permission to access this.";
      case 404:
        return "Data not found.";
      case 500:
        return "Server is down. Try later.";
      default:
        return "Unexpected error occurred.";
    }
  }

  static String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return "Network timeout. Check your internet.";
      case DioExceptionType.connectionError:
        return "No internet connection.";
      default:
        return "Something went wrong.";
    }
  }
}
