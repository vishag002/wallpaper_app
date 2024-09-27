import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/controller/wallpaper_controller.dart';
import 'package:wallpaper_app/view/bottom_nav_screen.dart';
import 'explore_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Prefetch wallpapers in the splash screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prefetchData();
    });
  }

  // Method to fetch wallpapers and navigate to HomeScreen
  void _prefetchData() async {
    await context.read<WallpaperProvider>().fetchWallpapers();

    // Navigate to HomeScreen after fetching data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      ),
    );
  }
}
