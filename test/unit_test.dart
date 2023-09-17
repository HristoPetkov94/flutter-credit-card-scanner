import 'package:flutter_credit_card_scanner/utils/validation_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isNumeric', () {
    test('Should return true for a valid numeric string', () {
      const numericString = '123.45';
      final result = ValidationUtils.isNumeric(numericString);
      expect(result, true);
    });

    test('Should return false for a non-numeric string', () {
      const nonNumericString = 'abc';
      final result = ValidationUtils.isNumeric(nonNumericString);
      expect(result, false);
    });

    test('Should return false for a null input', () {
      final result = ValidationUtils.isNumeric(null);
      expect(result, false);
    });
  });
}
