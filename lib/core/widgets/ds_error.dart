import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/size_extensions.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DSError extends StatelessWidget {
  const DSError({required this.title, required this.onTap, super.key});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: context.colorTheme.onSecondary,
            size: 40.r,
          ),
          8.hg,
          DSText(
            title,
            style: AppTextStyle.h6.bold,
            color: context.colorTheme.onSecondary,
          ),
          8.hg,
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Ink(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: context.colorTheme.tertiary,
              ),
              child: DSText(
                'Tentar Novamente',
                style: AppTextStyle.h7.bold,
                color: context.colorTheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
