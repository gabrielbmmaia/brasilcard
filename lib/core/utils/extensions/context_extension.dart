import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ColorScheme get colorTheme => Theme.of(this).colorScheme;

  void showSimpleSnackBar({required String text, Duration? duration}) =>
      ScaffoldMessenger.of(this)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: DSText(
              text,
              style: AppTextStyle.h6,
              color: colorTheme.primary,
            ),
            backgroundColor: colorTheme.tertiary,

            duration: duration ?? const Duration(seconds: 2),
          ),
        );
}
