import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ColorScheme get theme => Theme.of(this).colorScheme;
}
