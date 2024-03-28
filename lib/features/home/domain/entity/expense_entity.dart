import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';

class ExpenseEntity {
  final String expenseId;
  final String userId;
  final String title;
  final String note;
  final ExpenseCategory expenseCategory;
  final double expenseAmount;
  final DateTime expenseDate;

  ExpenseEntity({
    required this.expenseId,
    required this.userId,
    required this.title,
    required this.note,
    required this.expenseCategory,
    required this.expenseAmount,
    required this.expenseDate,
  });

  static ExpenseEntity empty() {
    return ExpenseEntity(
      expenseId: '',
      userId: '',
      title: '',
      note: '',
      expenseCategory: ExpenseCategory.misc,
      expenseAmount: 0,
      expenseDate: DateTime.now(),
    );
  }

  Map<String, dynamic> toJSON() => {
        "expenseId": expenseId,
        "userId": userId,
        "title": title,
        "note": note,
        "expenseCategory": enumValueToString(expenseCategory),
        "expenseAmount": expenseAmount,
        "expenseDate": expenseDate.toIso8601String(),
      };

  static ExpenseEntity toEntity(Map<String, dynamic> rawData) {
    return ExpenseEntity(
        expenseId: rawData['expenseId'],
        userId: rawData['userId'],
        title: rawData['title'],
        note: rawData['note'],
        expenseCategory: convertStringToEnum(
            ExpenseCategory.values, rawData['expenseCategory']),
        expenseAmount: rawData['expenseAmount'],
        expenseDate: DateTime.parse(rawData['expenseDate']));
  }
}
