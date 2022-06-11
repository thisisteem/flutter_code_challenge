import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBeerPreferences {
  static late SharedPreferences _preferences;

  static const _keyFavorite = 'favorite';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future addToFavorite(String id) async {
    List currentList = getFavorite();

    if (!currentList.contains(id)) {
      await _preferences.setStringList(_keyFavorite, [...currentList, id]);
    }
  }

  static Future removeFromFavorite(String id) async {
    List currentList = getFavorite();
    currentList.removeWhere((item) => item == id);
    await _preferences.setStringList(_keyFavorite, [...currentList]);
  }

  static List getFavorite() {
    return _preferences.getStringList(_keyFavorite) ?? [];
  }
}
