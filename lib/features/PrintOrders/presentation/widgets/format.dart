 import 'package:easy_localization/easy_localization.dart';

String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '-';
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat.yMMMd().format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String formatValue(double? value) {
  if (value == null || value.isNaN) {
    return '0.000 د.ك';
  }

  // Always show 3 decimal places
  final formatter = NumberFormat("#,##0.000", "en");
  return '${formatter.format(value)} د.ك';
}
