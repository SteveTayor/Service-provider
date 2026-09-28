// import 'package:bundlegram/core/extensions/responsive_extensions.dart';
// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/extensions/widget_extensions.dart';
// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';
// import 'package:bundlegram/presentation/features/airtime-to-cash-feature/screens/airtime_to_cash_history_screen.dart';
// import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/conversion_flow_sheet.dart';
// import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_list_widget.dart';
// import 'package:bundlegram/presentation/general_widget/app_bar.dart';
// import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
// import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AirtimeToCashScreen extends ConsumerWidget {
//   const AirtimeToCashScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final historyNotifier = ref.read(airtimeToCashHistoryProvider.notifier);

//     return BundlegramScaffold(
//       sidePadding: EdgeInsets.zero,
//       appBar: BundlegramAppbar(
//         titleText: 'Airtime to Cash',
//         trailing: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const AirtimeToCashHistoryScreen(),
//               ),
//             );
//           },
//           child: Text(
//             'History',
//             style: context.textTheme.labelSmall?.copyWith(
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           RefreshIndicator(
//             onRefresh: historyNotifier.refresh,
//             child: CustomScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               slivers: [
//                 // Intro
//                 SliverPadding(
//                   padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
//                   sliver: const SliverToBoxAdapter(child: _IntroCard()),
//                 ),

//                 SliverToBoxAdapter(child: SizedBox(height: 20.h)),

//                 // Recent conversions title
//                 SliverPadding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.w),
//                   sliver: const SliverToBoxAdapter(
//                     child: _RecentConversionsTopCard(),
//                   ),
//                 ),

//                 // Search
//                 // SliverPadding(
//                 //   padding: EdgeInsets.symmetric(
//                 //     horizontal: 8.w,
//                 //   ),
//                 //   sliver: const SliverToBoxAdapter(
//                 //     child: _SearchHeader(),
//                 //   ),
//                 // ),
//                 SliverPadding(
//                   padding: EdgeInsets.symmetric(horizontal: 8.w),
//                   sliver: SliverPersistentHeader(
//                     pinned: true,
//                     delegate: _SearchHeaderDelegate(),
//                   ),
//                 ),

//                 // Transactions
//                 SliverPadding(
//                   padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 104.h),
//                   sliver: const SliverToBoxAdapter(
//                     child: _RecentConversionsBottomCard(),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Floating action button
//           Positioned(
//             right: 16.w,
//             bottom: 20.h,
//             child: SafeArea(
//               top: false,
//               left: false,
//               child: _ConvertFab(
//                 onPressed: () => showAirtimeToCashConversionSheet(context),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Title section of the recent conversions card.
// class _RecentConversionsTopCard extends StatelessWidget {
//   const _RecentConversionsTopCard();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
//         border: const Border(
//           top: BorderSide(color: AppColors.greyEE),
//           left: BorderSide(color: AppColors.greyEE),
//           right: BorderSide(color: AppColors.greyEE),
//         ),
//       ),
//       child: Text(
//         'Recent Conversions',
//         style: context.textTheme.titleSmall?.copyWith(
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
// }

// /// Static search section.
// ///
// /// It is deliberately a normal SliverToBoxAdapter rather than
// /// a SliverPersistentHeader. The entire screen already has one
// /// CustomScrollView, so there is no need to make the search field
// /// another special scrolling viewport.
// ///
// class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   double get minExtent => 64.h;

//   @override
//   double get maxExtent => 64.h;

//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(8.w, 2.h, 8.w, 2.h),
//       decoration: BoxDecoration(
//         color: AppColors.white,

//         // Keep the same side/bottom borders as the surrounding
//         // Recent Conversions card so the sections visually connect.
//         border: const Border(
//           left: BorderSide(color: AppColors.greyEE),
//           right: BorderSide(color: AppColors.greyEE),
//           bottom: BorderSide(color: AppColors.greyEE),
//         ),

//         // Once the header becomes pinned and content is moving
//         // underneath it, add a very subtle shadow so the separation
//         // is visually clear.
//         boxShadow: overlapsContent
//             ? [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.04),
//                   blurRadius: 4,
//                   offset: const Offset(0, 2),
//                 ),
//               ]
//             : null,
//       ),
//       child: Consumer(
//         builder: (context, ref, _) {
//           final notifier = ref.read(airtimeToCashHistoryProvider.notifier);

//           return AppTextField(
//             decoration: const InputDecoration().search(),
//             onChange: notifier.onSearchChanged,
//           );
//         },
//       ),
//     );
//   }

//   // Nothing inside this delegate changes as a result of scrolling,
//   // so Flutter does not need to rebuild it during normal scrolling.
//   @override
//   bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) {
//     return false;
//   }
// }

// // class _SearchHeader extends ConsumerWidget {
// //   const _SearchHeader();

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final notifier =
// //         ref.read(airtimeToCashHistoryProvider.notifier);

// //     return Container(
// //       width: double.infinity,
// //       padding: EdgeInsets.fromLTRB(
// //         8.w,
// //         2.h,
// //         8.w,
// //         2.h,
// //       ),
// //       decoration: const BoxDecoration(
// //         color: AppColors.white,
// //         border: Border(
// //           left: BorderSide(
// //             color: AppColors.greyEE,
// //           ),
// //           right: BorderSide(
// //             color: AppColors.greyEE,
// //           ),
// //           bottom: BorderSide(
// //             color: AppColors.greyEE,
// //           ),
// //         ),
// //       ),
// //       child: AppTextField(
// //         decoration: const InputDecoration().search(),
// //         onChange: notifier.onSearchChanged,
// //       ),
// //     );
// //   }
// // }

// /// Bottom section containing the transaction content.
// class _RecentConversionsBottomCard extends StatelessWidget {
//   const _RecentConversionsBottomCard();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
//         border: const Border(
//           left: BorderSide(color: AppColors.greyEE),
//           right: BorderSide(color: AppColors.greyEE),
//           bottom: BorderSide(color: AppColors.greyEE),
//         ),
//       ),
//       child: const TransactionListWidget(limit: 5),
//     );
//   }
// }

// class _IntroCard extends StatefulWidget {
//   const _IntroCard();

//   @override
//   State<_IntroCard> createState() => _IntroCardState();
// }

// class _IntroCardState extends State<_IntroCard> {
//   bool _expanded = true;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(8.w),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: AppColors.greyEE),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _expanded = !_expanded;
//               });
//             },
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Turn Airtime into Cash',
//                     style: context.textTheme.titleSmall?.copyWith(
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8.w),
//                 AnimatedRotation(
//                   turns: _expanded ? 0.5 : 0,
//                   duration: const Duration(milliseconds: 200),
//                   child: Icon(
//                     Icons.keyboard_arrow_down_rounded,
//                     size: 22.sp,
//                     color: AppColors.grey80,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           AnimatedCrossFade(
//             firstChild: const SizedBox(width: double.infinity, height: 0),
//             secondChild: Padding(
//               padding: EdgeInsets.only(top: 6.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Convert your unused airtime to cash securely and conveniently.',
//                     style: context.textTheme.bodySmall?.copyWith(
//                       color: AppColors.grey80,
//                       height: 1.45,
//                     ),
//                   ),
//                   SizedBox(height: 8.h),
//                   Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 14.w,
//                       vertical: 12.h,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.greyF5,
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: const Row(
//                       children: [
//                         _FlowPill(label: 'Airtime', highlighted: true),
//                         _FlowArrow(),
//                         _FlowPill(label: 'Conversion'),
//                         _FlowArrow(),
//                         _FlowPill(label: 'Cash', highlighted: true),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 14.h),
//                   Text(
//                     '    Fast processing • Secure • Transparent rates',
//                     textAlign: TextAlign.center,
//                     style: context.textTheme.labelSmall?.copyWith(
//                       color: AppColors.primaryColor.withOpacity(.8),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             crossFadeState: _expanded
//                 ? CrossFadeState.showSecond
//                 : CrossFadeState.showFirst,
//             duration: const Duration(milliseconds: 200),
//             sizeCurve: Curves.easeInOut,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _FlowPill extends StatelessWidget {
//   const _FlowPill({required this.label, this.highlighted = false});

//   final String label;
//   final bool highlighted;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 6.w),
//         decoration: BoxDecoration(
//           color: highlighted
//               ? AppColors.primaryColor.withOpacity(0.08)
//               : AppColors.white,
//           borderRadius: BorderRadius.circular(10.r),
//           border: Border.all(
//             color: highlighted
//                 ? AppColors.primaryColor.withOpacity(0.8)
//                 : AppColors.greyEE,
//           ),
//         ),
//         child: Text(
//           label,
//           textAlign: TextAlign.center,
//           style: context.textTheme.labelSmall?.copyWith(
//             fontSize: 9.sp,
//             color: highlighted ? AppColors.success : AppColors.black,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _FlowArrow extends StatelessWidget {
//   const _FlowArrow();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 5.w),
//       child: Icon(
//         Icons.arrow_forward_rounded,
//         size: 12.sp,
//         color: AppColors.grey80,
//       ),
//     );
//   }
// }

// class _ConvertFab extends StatelessWidget {
//   const _ConvertFab({required this.onPressed});

//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton.extended(
//       onPressed: onPressed,
//       elevation: 5,
//       icon: const Icon(Icons.add_rounded),
//       label: const Text('Convert Airtime'),
//       backgroundColor: AppColors.primaryColor,
//       foregroundColor: AppColors.white,
//       extendedPadding: EdgeInsets.symmetric(horizontal: 8.w),
//     );
//   }
// }

import 'dart:async';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/currency_formatter/currency_input_formatter.dart';
import 'package:bundlegram/data/models/airtime_2_cash/network_config.dart';
import 'package:bundlegram/presentation/features/Bundlegram_Platform/screens/widget/platformphonenumberform_widget.dart'
    show formatPhone;
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/model/airtime_to_cash_state.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/screens/airtime_to_cash_history_screen.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/balance_too_low_dialog.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/confirm_transaction_dialog.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/new/airtime_otp_dialog.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/new/airtime_share_pin_dialog.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/result_status_dialog.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_list_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_listtile.dart';
import 'package:bundlegram/presentation/general_widget/app_loader.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirtimeToCashScreen extends ConsumerStatefulWidget {
  const AirtimeToCashScreen({super.key});

  @override
  ConsumerState<AirtimeToCashScreen> createState() =>
      _AirtimeToCashScreenState();
}

class _AirtimeToCashScreenState extends ConsumerState<AirtimeToCashScreen> {
  final _otpController = TextEditingController();
  bool _otpOpen = false;
  bool _pinOpen = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_prefillPhone);
  }

  void _prefillPhone() {
    if (!mounted) return;
    final notifier = ref.read(airtimeToCashProvider.notifier);
    final phone = ref.read(airtimeToCashProvider).phoneController;
    final profile = ref.read(globalProvider).profile.value?.data;
    if (profile != null && phone.text.trim().isEmpty) {
      phone.text = formatPhone(profile.phone);
    }
    notifier.detectNetworkFromPhone(phone.text);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _popDialog() => Navigator.of(context, rootNavigator: true).pop();

  void _onStepChanged(AirtimeToCashState next) {
    final notifier = ref.read(airtimeToCashProvider.notifier);
    final step = next.step;
    final inOtp =
        step == AirtimeToCashStep.otpEntry ||
        step == AirtimeToCashStep.verifyingOtp;

    // The listener is the only place that closes the OTP / PIN dialogs.
    if (_otpOpen && !inOtp) {
      _otpOpen = false;
      _popDialog();
    }
    if (_pinOpen && step != AirtimeToCashStep.pinEntry) {
      _pinOpen = false;
      _popDialog();
    }

    switch (step) {
      case AirtimeToCashStep.otpEntry:
        if (!_otpOpen) {
          _otpOpen = true;
          _otpController.clear();
          unawaited(
            context.showBottomSheet(
              child: AirtimeOtpDialog(controller: _otpController),
            ),
          );
        }
        break;

      case AirtimeToCashStep.balanceTooLow:
        if (next.selectedNetwork != null) {
          BalanceTooLowDialog.show(
            context,
            network: next.selectedNetwork!,
            balance: next.airtimeBalance,
          ).then((_) {
            if (mounted) notifier.cancelFlow();
          });
        }
        break;

      case AirtimeToCashStep.pinEntry:
        if (!_pinOpen) {
          _pinOpen = true;
          unawaited(
            context.showBottomSheet(child: const AirtimeSharePinDialog()),
          );
        }
        break;

      case AirtimeToCashStep.confirming:
        _handleConfirming(next);
        break;

      case AirtimeToCashStep.success:
        final txn = next.lastTransaction;
        if (txn == null) break;
        ResultStatusDialog.show(
          context,
          kind: ResultStatusKind.success,
          title: 'Conversion Successful',
          message:
              '₦${txn.amountReceived.toStringAsFixed(0)} has been added from your '
              '₦${txn.amountSold.toStringAsFixed(0)} airtime conversion.',
          primaryLabel: 'Done',
          onPrimaryPressed: () {
            _popDialog();
            notifier.resetAfterResult();
          },
        );
        break;

      case AirtimeToCashStep.processing:
        final txn = next.lastTransaction;
        if (txn == null) break;
        ResultStatusDialog.show(
          context,
          kind: ResultStatusKind.processing,
          title: 'Conversion Processing',
          message:
              txn.failureReason ??
              'Your conversion is being processed. You will be credited once the network confirms.',
          primaryLabel: 'Done',
          onPrimaryPressed: () {
            _popDialog();
            notifier.resetAfterResult();
          },
        );
        break;

      case AirtimeToCashStep.partial:
        final txn = next.lastTransaction;
        if (txn == null) break;
        final failedAmount = txn.amountSold - txn.amountReceived;
        ResultStatusDialog.show(
          context,
          kind: ResultStatusKind.partial,
          title: 'Partially Successful',
          detailLines: [
            'Successfully converted: ₦${txn.amountReceived.toStringAsFixed(0)}',
            'Failed: ₦${failedAmount.toStringAsFixed(0)}',
          ],
          message:
              txn.failureReason ??
              'Some transactions could not be completed. Please contact support if needed.',
          primaryLabel: 'Done',
          onPrimaryPressed: () {
            _popDialog();
            notifier.resetAfterResult();
          },
        );
        break;

      case AirtimeToCashStep.failed:
        ResultStatusDialog.show(
          context,
          kind: ResultStatusKind.failure,
          title: 'Conversion Failed',
          message: next.submissionError ?? 'Please try again.',
          primaryLabel: 'Try Again',
          secondaryLabel: 'Close',
          onPrimaryPressed: () {
            _popDialog();
            notifier.backToPinEntry();
          },
          onSecondaryPressed: () {
            _popDialog();
            notifier.cancelFlow();
          },
        );
        break;

      default:
        break;
    }
  }

  Future<void> _handleConfirming(AirtimeToCashState s) async {
    final notifier = ref.read(airtimeToCashProvider.notifier);
    final network = s.selectedNetwork;
    final amount = double.tryParse(
      s.amountController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
    );
    if (network == null || amount == null) {
      notifier.cancelFlow();
      return;
    }

    final confirmed = await ConfirmTransactionDialog.show(
      context,
      network: network,
      phoneNumber: s.phoneController.text.trim(),
      amountToSell: amount,
      amountToReceive: s.amountToReceive,
    );
    if (!mounted) return;

    if (confirmed == true) {
      unawaited(notifier.confirmAndSubmit());
    } else if (confirmed == false) {
      notifier.backToPinEntry(); // back arrow
    } else {
      notifier.cancelFlow(); // X
    }
  }

  void _openBillerPicker(AirtimeToCashState state) {
    final notifier = ref.read(airtimeToCashProvider.notifier);
    context.showBottomSheet(
      child: _BillerPicker(
        networks: state.networks,
        selectedId: state.selectedNetwork?.id,
        onSelected: (n) {
          notifier.selectNetwork(n);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(airtimeToCashProvider);
    final notifier = ref.read(airtimeToCashProvider.notifier);
    // final historyNotifier = ref.read(airtimeToCashHistoryProvider.notifier);

    ref
      ..listen<AirtimeToCashState>(airtimeToCashProvider, (previous, next) {
        if (previous?.step == next.step) return;
        _onStepChanged(next);
      })
      ..listen(
        globalProvider.select((g) => g.profile),
        (_, __) => _prefillPhone(),
      );

    final network = state.selectedNetwork;

    return BundlegramScaffold(
      sidePadding: EdgeInsets.zero,
      appBar: BundlegramAppbar(
        titleText: 'Airtime to Cash',
        trailing: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AirtimeToCashHistoryScreen(),
              ),
            );
          },
          child: Text(
            'History',
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await notifier.fetchNetworks();
          // await historyNotifier.refresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.w),
          child: state.isLoadingNetworks
              ? Padding(
                  padding: EdgeInsets.all(24.w),
                  child: const Center(child: AppLoader()),
                )
              : state.networksError != null
              ? Column(
                  children: [
                    Text(state.networksError!, textAlign: TextAlign.center),
                    TextButton(
                      onPressed: notifier.fetchNetworks,
                      child: const Text('Try Again'),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Biller + phone,
                    AppTextField(
                      controller: state.phoneController,
                      hintText: 'Enter phone number',
                      keyboardType: TextInputType.number,
                      enabled: !state.isBusy,
                      onChange: notifier.detectNetworkFromPhone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      prefixIcon: GestureDetector(
                        onTap: () => _openBillerPicker(state),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            16.horizontalSpace,
                            network != null
                                ? CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.white,
                                    child: ClipOval(
                                      child: AppSvgIcon(
                                        path: network.logoAsset,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 15,
                                    child: Icon(
                                      Icons.sim_card_outlined,
                                      size: 16,
                                    ),
                                  ),
                            8.horizontalSpace,
                            AppSvgIcon(path: Assets.svgs.chevronDown),
                            8.horizontalSpace,
                          ],
                        ),
                      ),
                    ),
                    if (state.phoneError != null) _ErrorText(state.phoneError!),
                    if (state.otpSendError != null &&
                        state.step == AirtimeToCashStep.form)
                      _ErrorText(state.otpSendError!),

                    if (network != null) ...[
                      24.verticalSpace,
                      _AmountPresetGrid(
                        network: network,
                        state: state,
                        notifier: notifier,
                      ),
                      16.verticalSpace,
                      AppTextField(
                        controller: state.amountController,
                        hintText: 'Enter amount',
                        inputFormatters: [
                          CurrencyTextInputFormatter(decimalDigits: 0),
                        ],
                        keyboardType: TextInputType.number,
                        enabled: !state.isBusy,
                        onChange: notifier.onAmountChanged,
                        prefixIcon: Padding(
                          padding: context.symmetricPadding(24, 0),
                          child: Text('₦', style: context.textTheme.bodyMedium),
                        ),
                      ),
                      if (state.amountError != null)
                        _ErrorText(state.amountError!),
                      if (state.quotaError != null)
                        _ErrorText(state.quotaError!),
                      6.verticalSpace,
                      Text(
                        'Min ₦${network.minAmount.toStringAsFixed(0)} • Max ₦${network.maxAmount.toStringAsFixed(0)}',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: AppColors.grey80,
                          fontSize: 10.sp,
                        ),
                      ),
                      20.verticalSpace,
                      _ConversionSummary(network: network, state: state),
                    ],
                    32.verticalSpace,
                    BundlegramButton(
                      text: 'Verify and continue',
                      isLoading: state.isBusy,
                      isEnabled: !state.isBusy,
                      onPressed: notifier.startVerification,
                    ),
                    32.verticalSpace,
                    // Text(
                    //   'Recent Conversions',
                    //   style: context.textTheme.titleSmall?.copyWith(
                    //     fontWeight: FontWeight.w700,
                    //   ),
                    // ),
                    // 12.verticalSpace,
                    // const TransactionListWidget(limit: 5),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: 6.h),
    child: Text(
      text,
      style: context.textTheme.bodySmall?.copyWith(color: AppColors.errorText),
    ),
  );
}

/// Same look as Airtime's "Choose Biller", but inactive billers stay in the
/// list greyed out and untappable.
class _BillerPicker extends StatelessWidget {
  const _BillerPicker({
    required this.networks,
    required this.selectedId,
    required this.onSelected,
  });

  final List<NetworkConfig> networks;
  final String? selectedId;
  final ValueChanged<NetworkConfig> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose Biller',
            style: context.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          24.verticalSpace,
          for (final n in networks) ...[
            Opacity(
              opacity: n.canUseInstantFlow ? 1 : 0.4,
              child: AppListTile(
                assetPath: n.logoAsset,
                title: n.name,
                showSubtitle: true,
                subtitle: n.canUseInstantFlow
                    ? 'Payout ${n.conversionRatePercent.toStringAsFixed(0)}%'
                    : 'Currently unavailable',
                isSelected: n.id == selectedId,
                onPressed: n.canUseInstantFlow ? () => onSelected(n) : null,
              ),
            ),
            24.verticalSpace,
          ],
        ],
      ),
    );
  }
}

List<int> _presetAmounts(NetworkConfig network) {
  final min = network.minAmount.round();
  final max = network.maxAmount.round();
  if (min >= max) return [min];
  final list = <int>[for (var v = min; v <= max; v += 1000) v];
  if (list.last != max) list.add(max);
  return list;
}

class _AmountPresetGrid extends StatelessWidget {
  const _AmountPresetGrid({
    required this.network,
    required this.state,
    required this.notifier,
  });

  final NetworkConfig network;
  final AirtimeToCashState state;
  final AirtimeToCashNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final amounts = _presetAmounts(network);
    final selected = int.tryParse(
      state.amountController.text.replaceAll(RegExp(r'[^0-9]'), ''),
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 10.w,
        mainAxisExtent: 54.h,
      ),
      itemCount: amounts.length,
      itemBuilder: (_, i) {
        final amount = amounts[i];
        final isSelected = selected == amount;
        return GestureDetector(
          onTap: state.isBusy
              ? null
              : () => notifier.selectPresetAmount(amount),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xffEEF3FF),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.grey83.withOpacity(0.2),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '₦$amount',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.primaryColor : AppColors.grey83,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ConversionSummary extends StatelessWidget {
  const _ConversionSummary({required this.network, required this.state});

  final NetworkConfig network;
  final AirtimeToCashState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("You'll receive", style: context.textTheme.bodySmall),
          SizedBox(height: 4.h),
          Text(
            '₦${state.amountToReceive.toStringAsFixed(0)}',
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text.rich(
            TextSpan(
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.grey80,
              ),
              children: [
                const TextSpan(text: 'Payout: '),
                TextSpan(
                  text: '${network.conversionRatePercent.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text:
                      ' (${(100 - network.conversionRatePercent).toStringAsFixed(0)}% fee deducted)',
                  style: const TextStyle(color: AppColors.grey33),
                ),
                if (state.tariffPlan != null) ...[
                  const TextSpan(text: ' • '),
                  TextSpan(
                    text: state.tariffPlan!,
                    style: const TextStyle(
                      color: AppColors.grey33,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
