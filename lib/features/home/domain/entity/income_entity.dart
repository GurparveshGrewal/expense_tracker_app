class IncomeEntity {
  final String userId;
  final String incomeId;
  final double amount;
  final DateTime date;

  IncomeEntity({
    required this.userId,
    required this.incomeId,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJSON() {
    return {
      "incomeId": incomeId,
      "userId": userId,
      "amount": amount.toString(),
      "date": date.toIso8601String(),
    };
  }

  IncomeEntity fromJSON(Map<String, dynamic> rawData) {
    return IncomeEntity(
      incomeId: rawData['incomeId'],
      userId: rawData['userId'],
      amount: double.parse(rawData['amount']),
      date: DateTime.parse(rawData['date']),
    );
  }
}
