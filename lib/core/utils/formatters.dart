import 'package:intl/intl.dart';

class DSFormatter {
  DSFormatter._();

  static String doubleToDollar(double value) {
    String symbol = '\$';
    String suffix = '';
    double shortValue = value;

    if (value >= 1_000_000_000_000) {
      shortValue = value / 1_000_000_000_000;
      suffix = 'T';
    } else if (value >= 1_000_000_000) {
      shortValue = value / 1_000_000_000;
      suffix = 'B';
    } else if (value >= 1_000_000) {
      shortValue = value / 1_000_000;
      suffix = 'M';
    }

    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: symbol,
      decimalDigits: 2,
    );

    return formatter.format(shortValue) + suffix;
  }

  static String formatNumberBR(double value, {int decimalDigits = 2}) {
    final formatter =
        NumberFormat.decimalPattern('pt_BR')
          ..minimumFractionDigits = decimalDigits
          ..maximumFractionDigits = decimalDigits;

    return formatter.format(value);
  }
}
