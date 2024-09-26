import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/api_model.dart';
import 'package:wallpaper_app/services/api_service.dart';

// New WallpaperProvider
class WallpaperProvider extends ChangeNotifier {
  List<MyClass>? _wallpapers;
  bool _isLoading = false;
  String? _errorMessage;

  List<MyClass>? get wallpapers => _wallpapers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWallpapers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final images = await WallpaperService().getMyClass();
      _wallpapers = images;
      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }

    notifyListeners();
  }
}
