import 'package:flutter/material.dart';

class DSText extends StatelessWidget {
  const DSText(
    this.title, {
    required this.style,
    required this.color,
    super.key,
  });

  final String title;
  final TextStyle style;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: style.copyWith(color: color));
  }
}
