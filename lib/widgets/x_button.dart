import 'package:flutter/material.dart';
import '../core/tokens.dart';

class XButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  const XButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: XTokens.md),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(XTokens.md)),
      ),
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(text),
    );
  }
}