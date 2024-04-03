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

String getTextForCurrency(Currency selectedCurrency) {
  switch (selectedCurrency) {
    case Currency.cad:
      return 'CA\$';
    case Currency.eur:
      return '€';
    case Currency.inr:
      return '₹';
    case Currency.usd:
      return '\$';
    default:
      return '?';
  }
}

IconData getIconForCurrency(Currency userCurrency) {
  switch (userCurrency) {
    case Currency.cad:
      return FontAwesomeIcons.dollarSign;
    case Currency.eur:
      return FontAwesomeIcons.euroSign;
    case Currency.inr:
      return FontAwesomeIcons.indianRupeeSign;
    case Currency.usd:
      return FontAwesomeIcons.dollarSign;
    default:
      return FontAwesomeIcons.exclamation;
  }
}

IconData getIconForExpenseCategory(ExpenseCategory category) {
  switch (category) {
    case ExpenseCategory.education:
      return FontAwesomeIcons.bookAtlas;
    case ExpenseCategory.entertainment:
      return FontAwesomeIcons.video;
    case ExpenseCategory.food:
      return FontAwesomeIcons.burger;
    case ExpenseCategory.grocery:
      return FontAwesomeIcons.kitchenSet;
    case ExpenseCategory.travel:
      return FontAwesomeIcons.car;
    case ExpenseCategory.misc:
      return Icons.extension_sharp;

    default:
      return Icons.abc;
  }
}
