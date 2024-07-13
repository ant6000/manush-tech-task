import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maush_tech_task/data/model/new_album_model.dart';

class AlbumCard extends StatelessWidget {
  final String title;
  final String url;
  final CustomAlbumModel albumImages;
  const AlbumCard(
      {required this.title,
      required this.url,
      required this.albumImages,
      super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double textSize = isPortrait ? 16.sp : 10.sp;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/albumImages',
          arguments: albumImages,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //height: 150.h,
            //width: 150.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              child: CachedNetworkImage(
                imageUrl: url,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            style: TextStyle(fontSize: textSize),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
