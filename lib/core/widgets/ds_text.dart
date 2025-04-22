import 'package:flutter/material.dart';

class DSText extends StatelessWidget {
  const DSText(
    this.title, {
    required this.style,
    required this.color,
    this.maxLines,
    this.alignment,
    this.overflow,
    super.key,
  });

  final String title;
  final TextStyle style;
  final Color color;
  final TextAlign? alignment;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style.copyWith(color: color),
      overflow: overflow,
      textAlign: alignment,
      maxLines: maxLines,
    );
  }
}
