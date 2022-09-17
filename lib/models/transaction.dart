class TransactionModel {
  final int amount;
  final String title;
  final String date;
  final String status;

  TransactionModel(
      {required this.amount,
      required this.date,
      required this.status,
      required this.title});
}
