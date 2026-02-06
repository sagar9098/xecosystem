import 'package:flutter/material.dart';

class XLoader extends StatelessWidget {
  const XLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}