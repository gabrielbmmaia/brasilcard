import 'package:brasilcard/core/theme/viewmodel/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late IThemeViewModel viewModel;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    viewModel = ThemeViewModel(mockSharedPreferences);
  });

  group('ThemeViewModel Tests', () {
    test('should load theme correctly from SharedPreferences', () async {
      when(() => mockSharedPreferences.getBool('isDarkMode')).thenReturn(true);
      viewModel.loadTheme();
      expect(viewModel.isDarkMode, true);
      expect(viewModel.themeMode, ThemeMode.dark);
    });

    test('should toggle theme to dark mode and save preference', () async {
      when(() => mockSharedPreferences.getBool('isDarkMode')).thenReturn(false);
      when(
        () => mockSharedPreferences.setBool(any(), any()),
      ).thenAnswer((_) async => true);
      viewModel.toggleTheme();
      expect(viewModel.isDarkMode, true);
      expect(viewModel.themeMode, ThemeMode.dark);
      verify(() => mockSharedPreferences.setBool('isDarkMode', true)).called(1);
    });

    test(
      'should use default theme (light) if no preference is saved',
      () async {
        when(
          () => mockSharedPreferences.getBool('isDarkMode'),
        ).thenReturn(null);
        viewModel.loadTheme();
        expect(viewModel.isDarkMode, false);
        expect(viewModel.themeMode, ThemeMode.light);
      },
    );
  });
}
