import 'package:flutter_test/flutter_test.dart';
import 'package:barbearia_app/main.dart';

void main() {
  testWidgets('BarberShopApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BarberShopApp());

    // Verify that our app shows the title.
    expect(find.text('BARBEARIA CLASSIC'), findsOneWidget);
    expect(find.text('Nossos Serviços'), findsOneWidget);
  });
}
