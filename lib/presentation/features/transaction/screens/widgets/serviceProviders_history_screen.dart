import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/currency_extension.dart';
import 'package:bundlegram/core/extensions/string_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_formatter.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/core/providers/service_provider.dart';
import 'package:bundlegram/core/utils/platform_provider_enums.dart';
import 'package:bundlegram/data/models/transaction/user_transactions_response.dart';
import 'package:bundlegram/data/models/transaction_receipt/transaction_receipt_model.dart';
import 'package:bundlegram/presentation/features/transaction/notifier/all_service_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/filter_widget.dart';
import 'package:bundlegram/presentation/features/wallet/notifier/wallet_service_state.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:bundlegram/presentation/general_widget/receipt_widget.dart';
import 'package:bundlegram/presentation/general_widget/service_list_item.dart';
import 'package:bundlegram/presentation/general_widget/transaction_share_receipt.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/emptytransaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ServiceHistoryScreen extends ConsumerStatefulWidget {
  const ServiceHistoryScreen({
    Key? key,
    required this.serviceType,
  }) : super(key: key);

  final PlatformProductType serviceType;

  @override
  ConsumerState<ServiceHistoryScreen> createState() =>
      _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends ConsumerState<ServiceHistoryScreen> {
  late final StateNotifierProvider<AllServiceHistoryNotifier,
      ServiceHistoryState> provider;
  String _sortBy = 'newest';
  String _amountBy = 'largest';
  final Set<String> _statusSet = {};
  final Set<String> _typeSet = {};
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    provider = {
      PlatformProductType.mobileData: mobileDataHistoryProvider,
      PlatformProductType.airtime: airtimeHistoryProvider,
      PlatformProductType.betting: bettingHistoryProvider,
      PlatformProductType.electricity: electricityHistoryProvider,
      PlatformProductType.education: educationHistoryProvider,
      PlatformProductType.cableTv: cableTvHistoryProvider,
      PlatformProductType.internetServices: internetServiceHistoryProvider,
      PlatformProductType.ePinVoucher: ePinHistoryProvider,
      PlatformProductType.bulkEPin: ePinHistoryProvider,
    }[widget.serviceType]!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(provider.notifier).refresh();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingMore) {
        _isLoadingMore = true;
        Future.microtask(() {
          ref.read(provider.notifier).loadMoreTransactions();
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
// ${widget.serviceType.name}
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: ' History',
        trailing: GestureDetector(
          onTap: () {
            context.showBottomSheet(
              child: TransactionFilterWidget(
                onApply: ({
                  required sortBy,
                  required amountBy,
                  required statusSet,
                  required typeSet,
                }) {
                  _sortBy = sortBy;
                  _amountBy = amountBy;
                  _statusSet
                    ..clear()
                    ..addAll(statusSet);
                  _typeSet
                    ..clear()
                    ..addAll(typeSet);

                  ref.read(provider.notifier).applyFilters(
                        sortBy: _sortBy,
                        amountBy: _amountBy,
                        statusSet: _statusSet,
                        typeSet: _typeSet,
                      );
                  context.pop();
                },
              ),
            );
          },
          child: Text(
            'Filter',
            style: context.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(provider.notifier).refresh();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: AppTextField(
                decoration: const InputDecoration().search(),
                onChange: (value) {
                  ref.read(provider.notifier).search(value);
                },
              ),
            ),
            20.verticalSpace,
            Expanded(
              child: state.filteredTransactions.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: EmptytransactionWidget()),
                    )
                  : ListView.separated(
                      controller: _scrollController,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 25),
                      itemCount: state.filteredTransactions.length + 1,
                      separatorBuilder: (_, __) => Container(
                        height: 1,
                        color: AppColors.greyD0.withOpacity(0.3),
                        margin: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      itemBuilder: (ctx, index) {
                        if (index == state.filteredTransactions.length) {
                          return state.filteredTransactions.length <
                                  state.allTransactions.length
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }
                        final txn = state.filteredTransactions[index];
                        return InkWell(
                          onTap: () => _showReceiptPopup(txn),
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

  void _showReceiptPopup(UserTransactions txn) {
    final dateTime = txn.createdAt ?? DateTime.now();

    TransactionReceiptData receiptData;
    final transTypeLower = (txn.transType ?? '').toLowerCase();

    if (transTypeLower.contains('airtime')) {
      // Handle airtime transaction
      receiptData = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(dateTime.toString()),
        time: _formatTime(dateTime.toString()),
        type: getTransactionType(txn),
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
      receiptData = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(dateTime.toString()),
        time: _formatTime(dateTime.toString()),
        type: getTransactionType(txn),
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
      receiptData = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(dateTime.toString()),
        time: _formatTime(dateTime.toString()),
        type: getTransactionType(txn),
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
    } else if (transTypeLower.contains('cable')) {
      // Handle data transaction
      receiptData = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(dateTime.toString()),
        time: _formatTime(dateTime.toString()),
        type: getTransactionType(txn),

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
      receiptData = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(dateTime.toString()),
        time: _formatTime(dateTime.toString()),
        type: getTransactionType(txn),

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
    } else if (transTypeLower.contains('fund_wallet')) {
      // Handle fund wallet transaction
      receiptData = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(dateTime.toString()),
        time: _formatTime(dateTime.toString()),
        type: getTransactionType(txn),
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
    } else {
      // Default case for other transaction types
      receiptData = TransactionReceiptData(
        transactionId: txn.transRef ?? 'BNG-${txn.id}',
        date: _formatDate(dateTime.toString()),
        time: _formatTime(dateTime.toString()),
        type: getTransactionType(txn) ?? 'N/A',
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
        data: receiptData,
        onShareReceipt: () async {
          await context
            ..pop()
            ..showPopUp(
              color: Colors.transparent,
              ReceiptShareWrapper(data: receiptData),
              isDismissable: true,
            );
        },
      ),
      isDismissable: true,
    );
  }

  String getTransactionType(UserTransactions data) {
    switch (data.transType?.toLowerCase()) {
      case 'mobile_data':
        return 'Mobile Data';
      case 'electricity':
        return 'Electricity';
      case 'airtime':
        return 'Airtime';
      case 'cable_tv':
        return 'Cable TV';
      case 'internet_service':
        return 'Internet Service';
      case 'fund_wallet':
        return 'Top-up';
      case 'withdrawal':
        return 'Withdrawal';
      case 'betting':
        return 'Betting';
      default:
        return data.transType!.capiTalizeFirstLast;
    }
  }

  String _formatDate(String dateStr) {
    final dt = dateStr.toDateTime();
    if (dt == null) return '--';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txnDate = DateTime(dt.year, dt.month, dt.day);

    if (txnDate.isAtSameMomentAs(today)) return 'Today';
    if (txnDate.isAtSameMomentAs(yesterday)) return 'Yesterday';

    return DateFormat('MMMM d, yyyy').format(dt); // e.g., July 15, 2025
  }

  String _formatTime(String dateStr) {
    try {
      final time = dateStr.toDateTime()?.toLocal();
      if (time == null) return '--:--';
      final hour = time.hour;
      final minute = time.minute;
      final period = hour >= 12 ? 'pm' : 'am';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}$period';
    } catch (e) {
      return '--:--';
    }
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
}
