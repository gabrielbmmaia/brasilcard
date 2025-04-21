import 'package:brasilcard/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DSLoadingIndicator extends StatelessWidget {
  const DSLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 36.h,
        width: 36.w,
        child: CircularProgressIndicator(
          color: context.theme.tertiary,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
