import 'package:flutter/material.dart';
import '../core/tokens.dart';

class XErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const XErrorView({super.key, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(XTokens.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, size: 64, color: XTokens.error),
            const SizedBox(height: XTokens.md),
            Text(message ?? "Something went wrong"),
            if (onRetry != null)
              ElevatedButton(onPressed: onRetry, child: const Text("Retry")),
          ],
        ),
      ),
    );
  }
}
