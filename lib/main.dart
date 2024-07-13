import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maush_tech_task/controller/album_controller.dart';
import 'package:maush_tech_task/core/routes.dart';
import 'package:maush_tech_task/views/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AlbumController()),
          ],
          child: MaterialApp(
            theme: ThemeData(),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
            },
            onGenerateRoute: generateRoute,
          ),
        );
      },
    );
  }
}
