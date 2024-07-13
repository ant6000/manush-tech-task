import 'package:dio/dio.dart';

abstract class HttpService {
  Future<Response> getData(String url);
  void init();
}
