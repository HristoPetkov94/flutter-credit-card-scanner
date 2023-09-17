import 'package:flutter/material.dart';
import 'package:flutter_credit_card_scanner/credit_card_page/credit_card_page.dart';
import 'package:flutter_credit_card_scanner/success_page/success_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CreditCardPage Widget Test', (WidgetTester tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CreditCardPage(),
        ),
      ),
    );

    expect(find.byType(CreditCardPage), findsOneWidget);

    final finderCardNameField = find.byKey(const Key('cardNameField'));
    await tester.enterText(finderCardNameField, 'Hristo Petkov');
    expect(find.text('Hristo Petkov'), findsOneWidget);

    final finderCardNumberField = find.byKey(const Key('cardNumberField'));
    await tester.enterText(finderCardNumberField, '1231313131312312');
    expect(find.text('1231313131312312'), findsOneWidget);

    final finderCardDateField = find.byKey(const Key('dateFormField'));
    await tester.enterText(finderCardDateField, '12/25');
    expect(find.text('12/25'), findsOneWidget);

    final finderCardCvvField = find.byKey(const Key('cardCvvField'));
    await tester.enterText(finderCardCvvField, '344');
    expect(find.text('344'), findsOneWidget);

    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(find.byType(SuccessPage), findsOneWidget);
  });
}
