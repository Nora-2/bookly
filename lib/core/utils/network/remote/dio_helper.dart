import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://www.googleapis.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    try {
      return await dio!.get(url, queryParameters: query);
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
