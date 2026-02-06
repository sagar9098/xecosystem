import 'package:flutter/material.dart';
import 'tokens.dart';

class XTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: XTokens.primary),
      scaffoldBackgroundColor: XTokens.surface,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}