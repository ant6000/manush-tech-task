import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maush_tech_task/data/model/album_image_model.dart';

class ImageThumbnail extends StatelessWidget {
  final String url;
  final AlbumImageModel imageModel;
  const ImageThumbnail(
      {
      required this.url,
      required this.imageModel,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/imageDetails',
          arguments: imageModel,
        );
      },
      child: Container(
        //height: 150.h,
        //width: 150.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.r))),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            child: CachedNetworkImage(
              imageUrl: url,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator( value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )),
      ),
    );
  }
}
