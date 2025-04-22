import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/text_style.dart';

class FieldText extends StatelessWidget {
  const FieldText({required this.field, required this.value, super.key});

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DSText(
          field,
          style: AppTextStyle.h7.bold,
          color: context.colorTheme.onSecondary,
        ),
        DSText(
          value,
          style: AppTextStyle.h7,
          color: context.colorTheme.onSecondary,
        ),
      ],
    );
  }
}
