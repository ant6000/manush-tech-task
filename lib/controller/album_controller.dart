import 'package:flutter/material.dart';
import 'package:maush_tech_task/data/model/album_image_model.dart';
import 'package:maush_tech_task/data/model/album_model.dart';
import 'package:maush_tech_task/data/model/new_album_model.dart';
import 'package:maush_tech_task/data/repository/fetch_album.dart';

class AlbumController extends ChangeNotifier {
  late FetchAlbumRepo _albumRepo;
  List<AlbumImageModel> albumImageList = [];
  List<AlbumModel> albumList = [];
  List<CustomAlbumModel> customAlbumList = [];
  List<CustomAlbumModel> paginatedAlbumList = [];
  List<CustomAlbumModel> searchList = [];
  bool isLoading = false;
  bool isPaginating = false;
  int currentPage = 0;
  final int itemsPerPage = 20;

  AlbumController() {
    _albumRepo = FetchAlbumRepoImp();
    fetchData();
  }

  Future<void> fetchData() async {
    await getAlbumImage();
    await getAlbumlist();
    createCustomAlbumList();
    loadMoreItems();
  }
// featching album data list
  Future<void> getAlbumImage() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _albumRepo.fetchAlbum('albums');
      final List<dynamic> jsonlist = response.data as List;
      if (response.statusCode == 200) {
        albumList = jsonlist.map((json) => AlbumModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('Failed to load images, status code: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  // featching album list
  Future<void> getAlbumlist() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _albumRepo.fetchImages('photos');
      final List<dynamic> jsonlist = response.data as List;
      if (response.statusCode == 200) {
        albumImageList =
            jsonlist.map((json) => AlbumImageModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('Failed to load albums, status code: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  // mapping album data with album lists
  void createCustomAlbumList() {
    customAlbumList = albumList.map((album) {
      List<AlbumImageModel> matchingAlbums =
          albumImageList.where((image) => image.albumId == album.id).toList();
      return CustomAlbumModel(
        id: album.id!,
        title: album.title!,
        albumImages: matchingAlbums,
      );
    }).toList();
    notifyListeners();
  }
  // paignation 
  void loadMoreItems() async {
    if (isPaginating || currentPage * itemsPerPage >= customAlbumList.length) {
      return;
    }
    isPaginating = true;
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    final int startIndex = currentPage * itemsPerPage;
    final int endIndex = (startIndex + itemsPerPage) > customAlbumList.length
        ? customAlbumList.length
        : startIndex + itemsPerPage;

    paginatedAlbumList.addAll(customAlbumList.sublist(startIndex, endIndex));
    currentPage++;
    isPaginating = false;
    isLoading = false;
    notifyListeners();
  }
  // searching data in album
  void searchAlbum(String value) {
    searchList = paginatedAlbumList
        .where((element) =>
            element.title!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
