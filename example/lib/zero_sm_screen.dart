import 'package:xecosystem/core/api.dart';
import 'package:xecosystem/widgets/x_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:xecosystem/widgets/x_scaffold.dart';
import 'package:xecosystem/widgets/x_text.dart';

class ZeroSmScreen extends StatefulWidget {
  const ZeroSmScreen({super.key});

  @override
  State<ZeroSmScreen> createState() => _ZeroSmScreenState();
}

class _ZeroSmScreenState extends State<ZeroSmScreen> {
  @override
  Widget build(BuildContext context) {
    return XScaffold(
      title: "Profile",
      body: XFutureBuilder<Map>(
        future: XApi.get("/users/1"),
        builder: (data) => XText("Name: ${data['name']}"),
      ),
    );
  }
}
