import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switchedon/models/drill.dart'; // Drill modelinizin yolu
import 'package:switchedon/globals.dart'; // globalDrills ve favDrills'in yolu

class FavoriteService extends ChangeNotifier {
  static const String _keyFavorites = 'favorites';
  static final FavoriteService _instance = FavoriteService._internal();
  factory FavoriteService() => _instance;
  FavoriteService._internal();

  static FavoriteService get instance => _instance;

  Set<int> _favoriteIds = {};

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteIds = prefs.getStringList(_keyFavorites);
    _favoriteIds = favoriteIds?.map((id) => int.parse(id)).toSet() ?? {};
    _updateFavDrills(); // Favori drill'ları güncelle
    notifyListeners(); // Notify listeners
  }

  Future<void> saveFavorites(Set<int> favoriteIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyFavorites, favoriteIds.map((id) => id.toString()).toList());
    _favoriteIds = favoriteIds;
    _updateFavDrills(); // Favori drill'ları güncelle
    notifyListeners(); // Notify listeners
  }

  void toggleFavorite(Drill drill) {
    if (_favoriteIds.contains(drill.id)) {
      _favoriteIds.remove(drill.id);
    } else {
      _favoriteIds.add(drill.id);
    }
    saveFavorites(_favoriteIds);
  }

  Set<int> getFavorites() => _favoriteIds;

  void _updateFavDrills() {
    favDrills = globalDrills.where((drill) => _favoriteIds.contains(drill.id)).toList();
  }
  Future<bool> isFavorite(Drill drill) async {
    final favoriteIds = getFavorites();
    return favoriteIds.contains(drill.id);
  }

  
}
