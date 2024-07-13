import 'package:dio/dio.dart';
import 'package:maush_tech_task/service/http_service.dart';

class HttpServiceImp implements HttpService {
  late Dio _dio;
  @override
  void init() {
    _dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));
    initializeIntercepto();
  }

  @override
  Future<Response> getData(String url) async {
    try {
      final response = await _dio.get(url);
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  initializeIntercepto() {
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        //print(response);
        handler.next(response);
      },
    ));
  }
}
