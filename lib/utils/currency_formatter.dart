import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatPrice(double price) {
    final formatter = NumberFormat('#,##0.00', 'pt');
    return formatter.format(price).replaceAll('.', ' ');
  }
}
