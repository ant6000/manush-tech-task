import 'package:maush_tech_task/data/model/album_image_model.dart';
class CustomAlbumModel {
  int? id;
  String? title;
  List<AlbumImageModel>? albumImages;

  CustomAlbumModel({
    required this.id,
    required this.title,
    required this.albumImages,
  });
}
