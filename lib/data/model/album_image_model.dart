//List<AlbumImageModel> AlbumImageModelFromJson(String str) => List<AlbumImageModel>.from(json.decode(str).map((x) => AlbumImageModel.fromJson(x)));

class AlbumImageModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnail;
  AlbumImageModel(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnail});

  factory AlbumImageModel.fromJson(Map<String, dynamic> json) => AlbumImageModel(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnail: json['thumbnailUrl']);
}

