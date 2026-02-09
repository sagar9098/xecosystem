import 'package:flutter/material.dart';
import '../core/api.dart';
import 'x_loader.dart';
import 'x_error_view.dart';

class XFutureBuilder<T> extends StatelessWidget {
  final Future<XResponse<T>> future;
  final Widget Function(T data) builder;

  const XFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<XResponse<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const XLoader();
        }

        if (snapshot.hasError) {
          return XErrorView(message: snapshot.error.toString());
        }

        if (!snapshot.hasData) {
          return const XErrorView(message: 'No data');
        }

        final response = snapshot.data!;

        return response.success
            ? builder(response.data as T)
            : XErrorView(message: response.message ?? 'Something went wrong');
      },
    );
  }
}
