import 'package:flutter_test/flutter_test.dart';
import 'package:xecosystem/xecosystem.dart';

void main() {
  testWidgets('XButton shows text', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: XButton(text: "Test")));
    expect(find.text("Test"), findsOneWidget);
  });

  testWidgets('XScaffold renders title', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: XScaffold(title: "Home", body: SizedBox()),
    ));
    expect(find.text("Home"), findsOneWidget);
  });
}