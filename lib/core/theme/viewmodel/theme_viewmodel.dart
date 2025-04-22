import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_viewmodel.g.dart';

class ThemeViewModel = IThemeViewModel with _$ThemeViewModel;

abstract class IThemeViewModel with Store {
  final SharedPreferences _sharedPreferences;
  static const _key = 'isDarkMode';

  @observable
  bool isDarkMode = false;

  @computed
  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  IThemeViewModel(this._sharedPreferences) {
    loadTheme();
  }

  @action
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    _saveTheme(isDarkMode);
  }

  void loadTheme() => isDarkMode = _sharedPreferences.getBool(_key) ?? false;

  Future<void> _saveTheme(bool value) async {
    await _sharedPreferences.setBool(_key, value);
  }
}
