import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xecosystem/xecosystem.dart';

void main() {
  testWidgets('XButton renders text and loading state', (tester) async {
    await tester
        .pumpWidget(MaterialApp(home: XButton(text: "Test", onPressed: () {})));
    expect(find.text("Test"), findsOneWidget);

    await tester.pumpWidget(MaterialApp(
        home: XButton(text: "Test", loading: true, onPressed: () {})));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('XScaffold renders title', (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: XScaffold(title: "Test", body: SizedBox())));
    expect(find.text("Test"), findsOneWidget);
  });
}
