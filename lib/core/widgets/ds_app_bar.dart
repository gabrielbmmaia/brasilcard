import 'package:brasilcard/core/theme/text_style.dart';
import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:brasilcard/core/utils/extensions/text_style_extension.dart';
import 'package:brasilcard/core/widgets/ds_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DsAppBar({
    required this.title,
    this.actions,
    this.centerTitle = false,
    super.key,
  }) : onLeadingTap = null;

  final String title;
  final List<Widget>? actions;
  final VoidCallback? onLeadingTap;
  final bool centerTitle;

  const DsAppBar.withBackButton({
    required this.title,
    this.onLeadingTap,
    this.actions,
    this.centerTitle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorTheme.secondary,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: DSText(
        title,
        style: AppTextStyle.h5.semiBold,
        color: context.colorTheme.tertiary,
      ),
      leading:
          onLeadingTap != null
              ? IconButton(
                onPressed: onLeadingTap,
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: context.colorTheme.tertiary,
                  size: 24.r,
                ),
              )
              : null,
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
