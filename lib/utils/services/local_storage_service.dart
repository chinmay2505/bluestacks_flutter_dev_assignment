/// In this file shared_preference plugin is used to store the
/// data locally in the application
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class
class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  LocalStorageService._internal();

  static Future<LocalStorageService?> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._internal();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  /// is user logged in flag
  bool get isUserLoggedIn => _getDataFromDisk("IS_USER_LOGGED_IN") ?? false;
  set isUserLoggedIn(bool value) => _saveDataToDisk("IS_USER_LOGGED_IN", value);

  /// Logged in Username
  String get loggedInUsername => _getDataFromDisk("LOG_IN_USERNAME") ?? "";
  set loggedInUsername(String value) =>
      _saveDataToDisk("LOG_IN_USERNAME", value);

  /// This function gets the data from the disk
  dynamic _getDataFromDisk(String key) => _preferences?.get(key);

  /// This function saves the data on the disk
  void _saveDataToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences?.setString(key, content);
    } else if (content is bool) {
      _preferences?.setBool(key, content);
    } else if (content is int) {
      _preferences?.setInt(key, content);
    } else if (content is double) {
      _preferences?.setDouble(key, content);
    } else if (content is List<String>) {
      _preferences?.setStringList(key, content);
    } else {
      _preferences?.setString(key, content.toString());
    }
  }
}
