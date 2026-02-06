import 'package:dio/dio.dart';

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

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    return success ? success(data as T) : error(message!);
  }
}

class XApi {
  static late Dio _dio;

  static void init({required String baseUrl}) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    // Add interceptors later if needed
  }

  static Future<XResponse<T>> get<T>(String path) async {
    try {
      final res = await _dio.get(path);
      return XResponse.success(res.data as T);
    } on DioException catch (e) {
      return XResponse.error(e.message ?? "Network error");
    }
  }

  static Future<XResponse<T>> post<T>(String path, {dynamic data}) async {
    try {
      final res = await _dio.post(path, data: data);
      return XResponse.success(res.data as T);
    } on DioException catch (e) {
      return XResponse.error(e.message ?? "Network error");
    }
  }
}