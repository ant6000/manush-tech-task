import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maush_tech_task/data/model/album_image_model.dart';

class ImageDetailsPage extends StatelessWidget {
  final AlbumImageModel albumImageModel;
  const ImageDetailsPage({required this.albumImageModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albumImageModel.title ?? ''),
        centerTitle: true,
      ),
      body: CachedNetworkImage(
        height: 600.h,
        width: 600.w,
        imageUrl: albumImageModel.url ?? '',
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress)),
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
