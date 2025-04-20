import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension WidgetExt on Widget {
  Widget all(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  Widget symmetric({double? vertical, double? horizontal}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (horizontal ?? 0).h,
        vertical: (vertical ?? 0).w,
      ),
    );
  }
}
