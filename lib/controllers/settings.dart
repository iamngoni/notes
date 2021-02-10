import 'package:flutter/material.dart';
import 'package:notes/utils/preferences.dart';

class SettingsState extends ChangeNotifier {
  Map<String, dynamic> _preferences = {};
  JsonPreferences _prefs = new JsonPreferences();

  init() async {
    await _prefs.init();
    this._preferences = _prefs.readFromFile();
    notifyListeners();
  }

  changeDarkMode() async {
    _prefs.writeToFile("dark_mode", !_preferences['dark_mode']);
    await this.init();
  }

  String get username => _preferences['name'];
  bool get darkMode => _preferences['dark_mode'];
}
