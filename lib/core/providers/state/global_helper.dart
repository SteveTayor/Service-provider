import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';

List<UserTransactions> mergeAndSortTransactions(
  Map<String, List<UserTransactions>> payload,
) {
  final merged = [
    ...payload['main']!,
    ...payload['epin']!,
  ]..sort((a, b) {
      final aDate = a.createdAt ?? DateTime(0);
      final bDate = b.createdAt ?? DateTime(0);
      return bDate.compareTo(aDate);
    });

  return merged;
}
