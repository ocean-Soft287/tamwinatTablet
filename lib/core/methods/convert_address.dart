import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

String localizeAddressToString(BuildContext context, String rawAddress) {
  // Map of Arabic label => English label
  final Map<String, String> replacements = {
    'المحافظة': tr('governorate'), // Governorate
    'المنطقة': tr('district'),     // District
    'القطعة': tr('block'),          // Block
    'الشارع': tr('street'),         // Street
    'المنزل': tr('building'),       // Building
    'الدور': tr('floor'),           // Floor
    'الشقة': tr('apartment'),       // Apartment
  };

  // Loop through all replacements and replace occurrences
  String result = rawAddress;
  replacements.forEach((arabicLabel, localizedLabel) {
    result = result.replaceAll(arabicLabel, localizedLabel);
  });

  return result;
}