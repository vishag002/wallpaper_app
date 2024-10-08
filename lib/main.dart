import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/carousel_controller.dart';
import 'package:wallpaper_app/controller/collection_controller.dart';
import 'package:wallpaper_app/controller/favourite_controller.dart';
import 'package:wallpaper_app/controller/theme_controller.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';
import 'package:wallpaper_app/utilis/color_const.dart';
import 'package:wallpaper_app/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.openBox('favorites');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CarouselControllerProvider()),
    ChangeNotifierProvider(create: (_) => WallpaperProvider()),
    ChangeNotifierProvider(create: (_) => CollectionProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AdaptiveTheme(
          light: lightTheme,
          dark: darkTheme,
          initial: themeProvider.themeMode,
          builder: (light, dark) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.transparent,
              statusBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
            ),
            child: GetMaterialApp(
              theme: light,
              darkTheme: dark,
              themeMode: themeProvider.themeMode == AdaptiveThemeMode.dark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
          ),
        );
      },
    );
  }
}
