import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_viewmodel.g.dart';

class ThemeViewModel = IThemeViewModel with _$ThemeViewModel;

abstract class IThemeViewModel with Store {
  static const _key = 'isDarkMode';

  @observable
  bool isDarkMode = false;

  @computed
  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  IThemeViewModel() {
    _loadTheme();
  }

  @action
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    _saveTheme(isDarkMode);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool(_key) ?? false;
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);
  }
}
