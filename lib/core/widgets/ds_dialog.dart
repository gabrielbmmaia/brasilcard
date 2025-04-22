import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:flutter/material.dart';

class DSDialog extends StatelessWidget {
  const DSDialog({required this.title, this.actions, super.key});

  final List<Widget>? actions;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colorTheme.primary,
      actions: actions,
      title: DSText(
        title,
        style: AppTextStyle.h6.semiBold,
        color: context.colorTheme.onPrimary,
        alignment: TextAlign.center,
      ),
    );
  }
}
