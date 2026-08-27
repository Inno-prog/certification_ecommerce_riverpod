import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalFavoritesDataSource {
  static const _key = 'favorite_product_ids';

  Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_key);
    if (jsonString == null) return {};
    final List<dynamic> list = json.decode(jsonString);
    return list.cast<String>().toSet();
  }

  Future<void> saveFavorites(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(ids.toList()));
  }

  Future<void> toggleFavorite(String productId, Set<String> current) async {
    final updated = Set<String>.from(current);
    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }
    await saveFavorites(updated);
  }
}
