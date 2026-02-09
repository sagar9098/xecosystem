import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xecosystem/core/api.dart';
import 'package:xecosystem/utils/extensions.dart';
import 'package:xecosystem/widgets/x_error_view.dart';
import 'package:xecosystem/widgets/x_loader.dart';
import 'package:xecosystem/widgets/x_text.dart';

class RiverPodScreen extends StatefulWidget {
  const RiverPodScreen({super.key});

  @override
  State<RiverPodScreen> createState() => _RiverPodScreenState();
}

class _RiverPodScreenState extends State<RiverPodScreen> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = FutureProvider<XResponse<Map>>(
      (ref) => XApi.get("/users/1"),
    );

    return Consumer(
      builder: (context, ref, _) {
        final res = ref.watch(profileProvider);
        return res.when(
          loading: () => const XLoader(),
          error: (_, __) =>
              XErrorView(onRetry: () => ref.refresh(profileProvider)),
          data: (response) => response.when(
            success: (data) => XText("Name: ${data['name']}"),
            error: (msg) => XErrorView(message: msg),
          ),
        );
      },
    );
  }
}
