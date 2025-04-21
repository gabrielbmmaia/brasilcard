import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension DoubleExt on num {
  SizedBox get hg => SizedBox(height: toDouble().h);

  SizedBox get wt => SizedBox(width: toDouble().w);
}
