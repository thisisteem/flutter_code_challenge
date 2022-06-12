import 'package:flutter_code_challenge/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'title is displayed',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.text('Your Beers'), findsOneWidget);
    },
  );

  testWidgets(
    'default value of dropdown menu is Beer color',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.text('Beer color'), findsOneWidget);
    },
  );
}
