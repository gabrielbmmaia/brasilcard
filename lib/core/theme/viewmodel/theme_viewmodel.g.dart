// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeViewModel on IThemeViewModel, Store {
  Computed<ThemeMode>? _$themeModeComputed;

  @override
  ThemeMode get themeMode =>
      (_$themeModeComputed ??= Computed<ThemeMode>(() => super.themeMode,
              name: 'IThemeViewModel.themeMode'))
          .value;

  late final _$isDarkModeAtom =
      Atom(name: 'IThemeViewModel.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$IThemeViewModelActionController =
      ActionController(name: 'IThemeViewModel', context: context);

  @override
  void toggleTheme() {
    final _$actionInfo = _$IThemeViewModelActionController.startAction(
        name: 'IThemeViewModel.toggleTheme');
    try {
      return super.toggleTheme();
    } finally {
      _$IThemeViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode},
themeMode: ${themeMode}
    ''';
  }
}
