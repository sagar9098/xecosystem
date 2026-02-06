import 'package:flutter/material.dart';
import '../core/tokens.dart';

class XInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  const XInput({super.key, required this.label, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(XTokens.md)),
        contentPadding: const EdgeInsets.all(XTokens.md),
      ),
    );
  }
}