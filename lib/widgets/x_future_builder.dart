import 'package:flutter/material.dart';
import 'x_loader.dart';
import 'x_error_view.dart';

class XFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) builder;

  const XFutureBuilder({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const XLoader();
        }
        if (snapshot.hasError) {
          return XErrorView(message: snapshot.error.toString());
        }
        return builder(snapshot.data as T);
      },
    );
  }
}