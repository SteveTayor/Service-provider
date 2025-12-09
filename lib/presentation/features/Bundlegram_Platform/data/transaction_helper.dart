import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/products/get_all_products_response.dart';
import 'package:bundlegram/data/models/products/get_sub_products_response.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';

TransactionReceiptData extractReceiptFromPurchaseResponse(
  Map<String, dynamic>? data, {
  PlatformProductType? serviceType,
  SubProduct? selectedSubProduct,
  Product? selectedProduct,
  String? originalAmount, // pass amount string you used in request if available
  String? beneficiary,
}) {
  // Safe get helpers
  T? _get<T>(Map<String, dynamic>? m, List<String> keys) {
    if (m == null) return null;
    for (final k in keys) {
      if (m.containsKey(k) && m[k] != null) return m[k] as T;
    }
    return null;
  }

  double? _parseDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    if (v is String) {
      final cleaned = v.replaceAll(',', '').trim();
      return double.tryParse(cleaned);
    }
    return null;
  }

  DateTime? _parseDate(String? s) {
    if (s == null) return null;
    var dt = DateTime.tryParse(s);
    if (dt != null) return dt;
    // attempt other common formats if needed — fallback to null
    return null;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown Date';

    final localDate = date.toLocal(); // <-- Always convert first
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txnDate = DateTime(localDate.year, localDate.month, localDate.day);

    if (txnDate.isAtSameMomentAs(today)) return 'Today';
    if (txnDate.isAtSameMomentAs(yesterday)) return 'Yesterday';

    return localDate.toIso8601String();
  }

  String _formatTime(DateTime? date) {
    if (date == null) return '--:--';

    final localDate = date.toLocal(); // <-- Always convert first
    final hour = localDate.hour;
    final minute = localDate.minute;
    final period = hour >= 12 ? 'pm' : 'am';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}$period';
  }

  // Look for id/refs/numbers in many common keys
  final transRef = _get<String>(data, [
        'trans_ref',
        'transRef',
        'trans_ref_no',
        'transaction_ref',
        'trx_ref'
      ]) ??
      _get<String>(data, ['trnxid', 'reference', 'ref']) ??
      'BNG-${_get<dynamic>(data, [
                'id'
              ]) ?? DateTime.now().millisecondsSinceEpoch}';

  final transType = (_get<String>(
              data, ['trans_type', 'transType', 'type', 'payment_type']) ??
          '')
      .toString()
      .toLowerCase();

  // amount: prefer deduct_amount -> amount -> deductAmount etc.
  final amountValue = _parseDouble(_get<dynamic>(
      data, ['deduct_amount', 'deductAmount', 'amount', 'deduct_amount_ng']));
  // fallback: use originalAmount if provided (try parse)
  final amountDouble = amountValue ?? _parseDouble(originalAmount);

  // display amount string (uses your CurrencyFormatter if available)
  String displayAmount() {
    if (amountDouble != null) {
      try {
        return CurrencyFormatter.format(amountDouble);
      } catch (_) {
        return amountDouble.toStringAsFixed(2);
      }
    }
    // fallback from any raw amount string present
    final raw = _get<String>(data, ['amount', 'deduct_amount', 'deductAmount']);
    if (raw != null && raw.isNotEmpty) return raw;
    if (originalAmount != null) return originalAmount;
    return '0.00';
  }

  // account/target fields
  final accountNumber = _get<String>(data, [
        'cr_acc',
        'crAcc',
        'account',
        'account_number',
        'smart_card',
        'meter'
      ]) ??
      beneficiary ??
      '';

  // balance before/after
  final balanceBefore =
      _get<dynamic>(data, ['balance_before', 'balanceBefore']);
  final balanceAfter = _get<dynamic>(data, ['balance_after', 'balanceAfter']);

  final createdAtRaw = _get<String>(data, ['created_at', 'createdAt', 'date']);
  final createdAt = _parseDate(createdAtRaw);

  // common additional fields
  final token = _get<String>(data, ['token', 'token_no', 'purchase_token']);
  final unit = _get<dynamic>(data, ['unit']);
  final cardPin = _get<String>(data, ['cardPin', 'card_pin', 'pin']);
  final status =
      _get<String>(data, ['status', 'transaction_status', 'state']) ??
          'Unknown';

  //  bundle name
  final description = _get<String>(data, [
        'description',
        'description_text',
        'sub_name',
        'subName',
        'sub_prod_name',
        'sub_prod',
        'product_name',
        'sub_product'
      ]) ??
      selectedSubProduct?.subName ??
      selectedProduct?.productName ??
      '';

  // Build final TransactionReceiptData mapping by transaction family
  if (transType.contains('airtime')) {
    return TransactionReceiptData(
      transactionId: transRef,
      date: _formatTime(createdAt),
      time: _formatTime(createdAt),
      type: transType,
      amount: displayAmount(),
      status: status,
      description: description,
      network: selectedProduct?.productName ??
          _get<String>(data, ['network', 'provider']),
      phoneNumber: accountNumber,
      userBalance: balanceAfter != null
          ? CurrencyFormatter.format(_parseDouble(balanceAfter))
          : null,
      balanceBefore: balanceBefore != null
          ? CurrencyFormatter.format(_parseDouble(balanceBefore))
          : null,
    );
  }

  if (transType.contains('data')) {
    return TransactionReceiptData(
      transactionId: transRef,
      date: _formatTime(createdAt),
      time: _formatTime(createdAt),
      type: transType,
      amount: displayAmount(),
      status: status,
      description: description,
      network: selectedProduct?.productName ??
          _get<String>(data, ['network', 'provider']),
      dataBundle: selectedSubProduct?.subName ?? description,
      phoneNumber: accountNumber,
      userBalance: balanceAfter != null
          ? CurrencyFormatter.format(_parseDouble(balanceAfter))
          : null,
      balanceBefore: balanceBefore != null
          ? CurrencyFormatter.format(_parseDouble(balanceBefore))
          : null,
    );
  }

  if (transType.contains('electricity')) {
    return TransactionReceiptData(
      transactionId: transRef,
      date: _formatTime(createdAt),
      time: _formatTime(createdAt),
      type: transType,
      amount: displayAmount(),
      status: status,
      description: description,
      meterNumber: accountNumber,
      token: token,
      userBalance: balanceAfter != null
          ? CurrencyFormatter.format(_parseDouble(balanceAfter))
          : null,
      balanceBefore: balanceBefore != null
          ? CurrencyFormatter.format(_parseDouble(balanceBefore))
          : null,
    );
  }

  if (transType.contains('cable')) {
    return TransactionReceiptData(
      transactionId: transRef,
      date: _formatTime(createdAt),
      time: _formatTime(createdAt),
      type: transType,
      amount: displayAmount(),
      status: status,
      description: description,
      smartCardNumber: accountNumber,
      userBalance: balanceAfter != null
          ? CurrencyFormatter.format(_parseDouble(balanceAfter))
          : null,
      balanceBefore: balanceBefore != null
          ? CurrencyFormatter.format(_parseDouble(balanceBefore))
          : null,
    );
  }

  if (transType.contains('withdrawal')) {
    return TransactionReceiptData(
      transactionId: transRef,
      date: _formatTime(createdAt),
      time: _formatTime(createdAt),
      type: transType,
      amount: displayAmount(),
      accountNumber: accountNumber,
      status: status,
      description: description,
      userBalance: balanceAfter != null
          ? CurrencyFormatter.format(_parseDouble(balanceAfter))
          : null,
      balanceBefore: balanceBefore != null
          ? CurrencyFormatter.format(_parseDouble(balanceBefore))
          : null,
    );
  }

  // fallback / default
  return TransactionReceiptData(
    transactionId: transRef,
    date: _formatTime(createdAt),
    time: _formatTime(createdAt),
    type: transType.isNotEmpty
        ? transType
        : (serviceType?.title ?? 'transaction'),
    amount: displayAmount(),
    accountNumber: accountNumber.isNotEmpty ? accountNumber : null,
    status: status,
    description: description,
    userBalance: balanceAfter != null
        ? CurrencyFormatter.format(_parseDouble(balanceAfter))
        : null,
    balanceBefore: balanceBefore != null
        ? CurrencyFormatter.format(_parseDouble(balanceBefore))
        : null,
  );
}
