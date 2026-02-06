import 'package:flutter/material.dart';
import '../core/tokens.dart';

class XScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final bool noAppBar;

  const XScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.noAppBar = false,
  });

  double _padding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return XTokens.xl;
    if (width > 600) return XTokens.lg;
    return XTokens.md;
  }

  @override
  Widget build(BuildContext context) {
    final padding = _padding(context);
    final child = Padding(
      padding: EdgeInsets.all(padding),
      child: body,
    );

    if (noAppBar) return Scaffold(body: SafeArea(child: child));

    return Scaffold(
      appBar: AppBar(title: title != null ? Text(title!) : null, actions: actions),
      body: SafeArea(child: child),
    );
  }
}