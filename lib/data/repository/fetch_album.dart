import 'package:dio/dio.dart';
import 'package:maush_tech_task/service/http_service.dart';
import 'package:maush_tech_task/service/http_service_imp.dart';

abstract class FetchAlbumRepo {
  Future<Response> fetchAlbum(String url);
  Future<Response> fetchImages(String url);

}

class FetchAlbumRepoImp implements FetchAlbumRepo {
  late HttpService _httpService;
  FetchAlbumRepoImp() {
    _httpService = HttpServiceImp();
    _httpService.init();
  }

  @override
  Future<Response> fetchAlbum(String url) {
    try {
      final response = _httpService.getData(url);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch album $e');
    }
  }

  
  @override
  Future<Response> fetchImages(String url) {
    try {
      final response = _httpService.getData(url);
      return response;
    } catch (e) {
      throw Exception('Failed to Fetch Image $e');
    }
  }
}
