import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TransactionScreen extends ConsumerStatefulWidget {
  const TransactionScreen({super.key});

  @override
  ConsumerState<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends ConsumerState<TransactionScreen> {
  String _sortBy = 'newest';
  String _amountBy = 'largest';
  final Set<String> _statusSet = {};
  final Set<String> _typeSet = {};
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(globalProvider.notifier)
          .fetchUsersTransactions(context, force: true);
      ref.read(transactionHistoryProvider.notifier).loadServices();
    });

    _scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent - 200) {
  //     // Avoid triggering multiple times while loading
  //     if (!_isLoadingMore) {
  //       _isLoadingMore = true;
  //       Future.microtask(() {
  //         ref.read(transactionHistoryProvider.notifier).loadMoreTransactions();
  //         _isLoadingMore = false;
  //       });
  //     }
  //   }
  // }
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(transactionHistoryProvider.notifier).loadMoreTransactions();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transactionHistoryProvider);
    final allTxns = state.filteredServices;

    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        showBackButton: false,
        titleText: 'Transactions',
        trailing: GestureDetector(
          onTap: () {
            context.showBottomSheet(
              child: TransactionFilterWidget(
                onApply: ({
                  required String sortBy,
                  required String amountBy,
                  required Set<String> statusSet,
                  required Set<String> typeSet,
                }) {
                  _sortBy = sortBy;
                  _amountBy = amountBy;
                  _statusSet
                    ..clear()
                    ..addAll(statusSet);
                  _typeSet
                    ..clear()
                    ..addAll(typeSet);

                  ref.read(transactionHistoryProvider.notifier).applyFilters(
                        typeSet: _typeSet,
                        statusSet: _statusSet,
                        sortBy: _sortBy,
                        amountBy: _amountBy,
                      );

                  context.pop();
                },
              ),
            );
          },
          child: Text(
            'Filter',
            style: context.textTheme.labelSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(globalProvider.notifier)
              .fetchUsersTransactions(context, force: true);
          ref.read(transactionHistoryProvider.notifier).refresh();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: AppTextField(
                decoration: const InputDecoration().search(),
                onChange: (value) {
                  ref.read(transactionHistoryProvider.notifier).search(value);
                },
              ),
            ),
            20.verticalSpace,
            Expanded(
              child: allTxns.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: EmptytransactionWidget()),
                    )
                  : ListView.separated(
                      controller: _scrollController,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 25),
                      itemCount: allTxns.length + 1,
                      separatorBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.only(bottom: 8, top: 10),
                        child: Divider(color: AppColors.divider),
                      ),
                      itemBuilder: (ctx, index) {
                        if (index == allTxns.length) {
                          final isLoadingMore = state.isLoadingMore;
                          final hasMore = state.hasMore;

                          if (!hasMore) return const SizedBox.shrink();
                          if (isLoadingMore) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2)),
                            );
                          }
                          return const SizedBox.shrink();
                        }

                        final txn = allTxns[index];
                        return InkWell(
                          onTap: () => _showTransactionDetails(txn),
                          child: ServiceListItem(transaction: txn),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTransactionDetails(UserTransactions txn) {
    // final data = TransactionReceiptData(
    //   transactionId: txn.transRef ?? 'BNG-${txn.id}',
    //   date: _formatDate(txn.createdAt),
    //   time: _formatTime(txn.createdAt),
    //   type: txn.transType != 'fund_wallet' && txn.transType != "withdrawal"
    //       ? txn.subProduct?.product?.productName
    //       : txn.transType ?? 'N/A',
    //   amount: txn.transType != 'fund_wallet' && txn.transType != "withdrawal"
    //       ? CurrencyFormatter.format(txn.deductAmount ?? 0.0)
    //       : txn.amount.toCurrency()),
    //   accountNumber: txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
    //   status: txn.status ?? 'Unknown',
    //   description:
    //       txn.subProduct?.subName ?? txn.subProduct?.product?.productName ?? '',
    // );
    // Construct receipt data dynamically based on transType contents
    TransactionReceiptData data;
    final transTypeLower = (txn.transType ?? '').toLowerCase();

    if (transTypeLower.contains('airtime')) {
      // Handle airtime transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        // type: txn.subProduct?.product?.productName,
        type: txn.transType,
        amount: txn.deductAmount.toCurrency(),
        // accountNumber:
        //     txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        network: txn.subProduct?.product?.productName,
        phoneNumber: txn.crAcc,
        userBalance: txn.balanceAfter?.toCurrency(),
        balanceBefore: txn.balanceBefore?.toCurrency(),
      );
    } else if (transTypeLower.contains('data')) {
      // Handle data transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        // type: txn.subProduct?.product?.productName,
        type: txn.transType,
        amount: txn.deductAmount.toCurrency(),
        // accountNumber:
        //     txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        network: txn.subProduct?.product?.productName,
        phoneNumber: txn.crAcc,
        userBalance: txn.balanceAfter?.toCurrency(),
        balanceBefore: txn.balanceBefore?.toCurrency(),
      );
    } else if (transTypeLower.contains('withdrawal')) {
      // Handle withdrawal transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: txn.transType,
        amount: txn.amount.toCurrency(),
        accountNumber:
            txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        userBalance: txn.balanceAfter?.toCurrency(),
        balanceBefore: txn.balanceBefore?.toCurrency(),
      );
    } else if (transTypeLower.contains('fund_wallet')) {
      // Handle fund wallet transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: txn.transType,
        amount: txn.amount.toCurrency(),
        accountNumber:
            txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
        paymentMethod: txn.paymentType ?? '',
        userBalance: txn.balanceAfter?.toCurrency(),
        balanceBefore: txn.balanceBefore?.toCurrency(),
      );
    } else if (transTypeLower.contains('cable')) {
      // Handle data transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: txn.transType,

        amount: txn.amount.toCurrency(),
        // accountNumber:
        //     txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',

        smartCardNumber: txn.crAcc,
        balanceBefore: txn.balanceBefore?.toCurrency(),
        userBalance: txn.balanceAfter?.toCurrency(),
      );
    } else if (transTypeLower.contains('electricity')) {
      // Handle data transaction
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: txn.transType,

        amount: txn.amount.toCurrency(),
        // accountNumber:
        //     txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',

        meterNumber: txn.crAcc,
        token: txn.token,
        balanceBefore: txn.balanceBefore?.toCurrency(),
        userBalance: txn.balanceAfter?.toCurrency(),
      );
    } else {
      // Default case for other transaction types
      data = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(txn.createdAt),
        time: _formatTime(txn.createdAt),
        type: txn.transType ?? 'N/A',
        amount: txn.transType != 'fund_wallet' && txn.transType != 'withdrawal'
            ? txn.deductAmount.toCurrency()
            : txn.amount.toCurrency(),
        accountNumber:
            txn.crAcc ?? _getDefaultAccountNumber(txn.transType ?? ''),
        status: txn.status ?? 'Unknown',
        description: txn.subProduct?.subName ??
            txn.subProduct?.product?.productName ??
            '',
              balanceBefore: txn.balanceBefore?.toCurrency(),
        userBalance: txn.balanceAfter?.toCurrency(),
      );
    }

    context.showPopUp(
      color: Colors.transparent,
      TransactionReceiptWidget(
        data: data,
        onShareReceipt: () {
          context
            ..pop()
            ..showPopUp(
              color: Colors.transparent,
              ReceiptShareWrapper(data: data),
              isDismissable: true,
            );
        },
        onClose: () => context.pop(),
      ),
      isDismissable: true,
    );
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

  String _getDefaultAccountNumber(String type) {
    switch (type.toLowerCase()) {
      case 'airtime':
      case 'data':
        return '080********';
      case 'electricity':
        return '1234567890';
      case 'withdrawal':
        return '305**********';
      case 'betting':
        return '********';
      default:
        return '0821971234';
    }
  }

  // Widget generateShareableReceipt(TransactionReceiptData data) {
  //   return VisualReceiptCard(data: data);
  // }
}
