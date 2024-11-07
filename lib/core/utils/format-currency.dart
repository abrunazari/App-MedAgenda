import 'package:intl/intl.dart';

String formatCurrency(double value) {
  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2);
  return currencyFormatter.format(value / 100).replaceAll('.', ',');
}
