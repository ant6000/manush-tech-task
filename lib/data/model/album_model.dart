
// List<AlbumModel> AlbumModelFromJson(String str) =>
//     List<AlbumModel>.from(json.decode(str).map((x) => AlbumModel.fromJson(x)));

class AlbumModel {
  int? userId;
  int? id;
  String? title;
  AlbumModel({required this.userId, required this.id, required this.title});

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      AlbumModel(userId: json['userId'], id: json['id'], title: json['title']);
}
