import 'package:flutter/material.dart';
import 'package:maush_tech_task/data/model/album_image_model.dart';
import 'package:maush_tech_task/data/model/new_album_model.dart';
import 'package:maush_tech_task/views/screens/album_details_page.dart';
import 'package:maush_tech_task/views/screens/home_page.dart';
import 'package:maush_tech_task/views/screens/image_details_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
    case '/albumImages':
      final args = settings.arguments as CustomAlbumModel;
      return MaterialPageRoute(
        builder: (context) => AlbumDetailsPage(albumImages: args),
      );
    case '/imageDetails':
      final args = settings.arguments as AlbumImageModel;
      return MaterialPageRoute(
        builder: (context) => ImageDetailsPage(
          albumImageModel: args,
        ),
      );
    default:
      throw Exception('Route not found!');
  }
}
