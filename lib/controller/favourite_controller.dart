import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoriteProvider extends ChangeNotifier {
  final Box<dynamic> _favoritesBox = Hive.box('favorites');

  List<String> get favorites => _favoritesBox.values.cast<String>().toList();

  bool isFavorite(String id) {
    return _favoritesBox.values.contains(id);
  }

  void toggleFavorite(String id) {
    if (isFavorite(id)) {
      _favoritesBox.delete(id);
    } else {
      _favoritesBox.put(id, id);
    }
    notifyListeners();
  }
}
