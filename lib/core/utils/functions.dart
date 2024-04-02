import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

String enumValueToString(Object? enumValue) =>
    enumValue.toString().split(".").last;

T convertStringToEnum<T>(Iterable<T> values, String? value) =>
    values.firstWhere(
      (type) => enumValueToString(type) == value,
      orElse: () =>
          throw Exception("$value is not part of ${values.first.runtimeType}"),
    );

String convertDateToReadable(DateTime timestamp) {
  return DateFormat.yMMMMd().format(timestamp);
}

IconData getIconForCurrency(Currency userCurrency) {
  switch (userCurrency) {
    case Currency.cad:
      return FontAwesomeIcons.dollarSign;

    case Currency.usd:
      return FontAwesomeIcons.dollarSign;

    case Currency.inr:
      return FontAwesomeIcons.indianRupeeSign;

    case Currency.eur:
      return FontAwesomeIcons.euroSign;

    default:
      return FontAwesomeIcons.exclamation;
  }
}
