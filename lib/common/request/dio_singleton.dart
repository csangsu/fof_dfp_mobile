import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class DioSingleton {
  late Dio _dio;
  DioSingleton._privateConstructor() {
    _dio = Dio();
    var cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        options.headers['Cache-Control'] = 'no-cache';
        handler.next(options);
      },
    ));
  }

  static final DioSingleton _instance = DioSingleton._privateConstructor();

  factory DioSingleton() => _instance;

  get dio => _dio;
}
