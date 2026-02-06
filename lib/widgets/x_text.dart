import 'package:flutter/material.dart';
import '../core/tokens.dart';

class XText extends StatelessWidget {
  final String data;
  final TextStyle? style;

  const XText(this.data, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
    );
  }
}