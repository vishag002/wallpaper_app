import 'package:flutter/foundation.dart';
import 'package:wallpaper_app/model/collection_api_model.dart';
import 'package:wallpaper_app/services/collection_api_service.dart';

class CollectionProvider with ChangeNotifier {
  List<CollectionClass> _collections = [];
  bool _isLoading = false;
  String _error = '';

  List<CollectionClass> get collections => _collections;
  bool get isLoading => _isLoading;
  String get error => _error;

  final CollectionApiService _apiService = CollectionApiService();

  Future<void> fetchCollections() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _collections = await _apiService.getCollectionClass();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void refreshCollections() {
    fetchCollections();
  }
}
