import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ColorScheme get colorTheme => Theme.of(this).colorScheme;
}
