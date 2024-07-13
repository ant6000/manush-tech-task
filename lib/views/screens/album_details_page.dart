import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maush_tech_task/data/model/new_album_model.dart';
import 'package:maush_tech_task/views/widgets/image_thumbnail.dart';

class AlbumDetailsPage extends StatelessWidget {
  final CustomAlbumModel albumImages;
  const AlbumDetailsPage({required this.albumImages, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albumImages.title ?? ''),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: GridView.builder(
                itemCount: albumImages.albumImages!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 4 : 5,
                  childAspectRatio:
                      orientation == Orientation.portrait ? 1 : 1,
                  mainAxisSpacing: 5.h,
                  crossAxisSpacing: 5.w,
                ),
                itemBuilder: (context, index) {
                  final data = albumImages.albumImages![index];
                  return ImageThumbnail(
                    url: data.thumbnail ?? '',
                    imageModel: data,
                  );
                },
              ));
        },
      ),
    );
  }
}
