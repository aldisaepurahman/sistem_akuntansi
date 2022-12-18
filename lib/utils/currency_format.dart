import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToCurrency(dynamic number) {
    NumberFormat currency = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: 0
    );
    return currency.format(number);
  }
}