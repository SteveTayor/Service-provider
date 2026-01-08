import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';

List<UserTransactions> applyTransactionFilters(
  Map<String, dynamic> args,
) {
  List<UserTransactions> list = args['list'] as List<UserTransactions>;
  Set<String> typeSet = args['typeSet'] as Set<String>;
  Set<String> statusSet = args['statusSet'] as Set<String>;
  String sortBy = args['sortBy'] as String;
  String amountBy = args['amountBy'] as String;

  var temp = list;

  if (typeSet.isNotEmpty) {
    temp = temp
        .where((transaction) => typeSet.contains(transaction.transType))
        .toList();
  }

  if (statusSet.isNotEmpty) {
    temp = temp
        .where((transaction) => statusSet.contains(transaction.status))
        .toList();
  }

  if (sortBy.isNotEmpty) {
    temp.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
  }

  if (amountBy.isNotEmpty) {
    temp.sort((a, b) => a.amount!.compareTo(b.amount!));
  }

  return temp;
}
