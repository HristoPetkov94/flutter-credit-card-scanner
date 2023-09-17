class ValidationUtils {
  static bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  static bool isValidExpiryDate(String input) {
    final RegExp dateFormat = RegExp(r'^\d{2}/\d{2}$');

    if (!dateFormat.hasMatch(input)) {
      return false;
    }

    final parts = input.split('/');
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) {
      return false;
    }

    final now = DateTime.now();
    final currentYear = now.year % 100;

    if (year < currentYear || year > currentYear + 20) {
      return false;
    }

    if (month < 1 || month > 12) {
      return false;
    }

    return true;
  }

  static String formatCardNumber(String cardNumber) {
    cardNumber = cardNumber.trim();

    final RegExp regExp = RegExp(r'\d{1,4}');
    Iterable<Match> matches = regExp.allMatches(cardNumber);

    String formattedNumber = '';
    for (Match match in matches) {
      formattedNumber += '${match.group(0)}-';
    }

    return formattedNumber.substring(0, formattedNumber.length - 1);
  }
}
