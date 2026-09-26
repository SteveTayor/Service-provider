import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/provider/airtime_to_cash_history_provider.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/screens/airtime_to_cash_history_screen.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/conversion_flow_sheet.dart';
import 'package:bundlegram/presentation/features/airtime-to-cash-feature/widgets/transaction_list_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AirtimeToCashScreen extends ConsumerWidget {
  const AirtimeToCashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyNotifier = ref.read(airtimeToCashHistoryProvider.notifier);

    return BundlegramScaffold(
      sidePadding: EdgeInsets.zero,
      appBar: BundlegramAppbar(
        titleText: 'Airtime to Cash',
        trailing: GestureDetector(
          onTap: () {
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
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: historyNotifier.refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Intro
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
                  sliver: const SliverToBoxAdapter(child: _IntroCard()),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                // Recent conversions title
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  sliver: const SliverToBoxAdapter(
                    child: _RecentConversionsTopCard(),
                  ),
                ),

                // Search
                // SliverPadding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 8.w,
                //   ),
                //   sliver: const SliverToBoxAdapter(
                //     child: _SearchHeader(),
                //   ),
                // ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  sliver: SliverPersistentHeader(
                    pinned: true,
                    delegate: _SearchHeaderDelegate(),
                  ),
                ),

                // Transactions
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 104.h),
                  sliver: const SliverToBoxAdapter(
                    child: _RecentConversionsBottomCard(),
                  ),
                ),
              ],
            ),
          ),

          // Floating action button
          Positioned(
            right: 16.w,
            bottom: 20.h,
            child: SafeArea(
              top: false,
              left: false,
              child: _ConvertFab(
                onPressed: () => showAirtimeToCashConversionSheet(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Title section of the recent conversions card.
class _RecentConversionsTopCard extends StatelessWidget {
  const _RecentConversionsTopCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
        border: const Border(
          top: BorderSide(color: AppColors.greyEE),
          left: BorderSide(color: AppColors.greyEE),
          right: BorderSide(color: AppColors.greyEE),
        ),
      ),
      child: Text(
        'Recent Conversions',
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Static search section.
///
/// It is deliberately a normal SliverToBoxAdapter rather than
/// a SliverPersistentHeader. The entire screen already has one
/// CustomScrollView, so there is no need to make the search field
/// another special scrolling viewport.
///
class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 64.h;

  @override
  double get maxExtent => 64.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 2.h, 8.w, 2.h),
      decoration: BoxDecoration(
        color: AppColors.white,

        // Keep the same side/bottom borders as the surrounding
        // Recent Conversions card so the sections visually connect.
        border: const Border(
          left: BorderSide(color: AppColors.greyEE),
          right: BorderSide(color: AppColors.greyEE),
          bottom: BorderSide(color: AppColors.greyEE),
        ),

        // Once the header becomes pinned and content is moving
        // underneath it, add a very subtle shadow so the separation
        // is visually clear.
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Consumer(
        builder: (context, ref, _) {
          final notifier = ref.read(airtimeToCashHistoryProvider.notifier);

          return AppTextField(
            decoration: const InputDecoration().search(),
            onChange: notifier.onSearchChanged,
          );
        },
      ),
    );
  }

  // Nothing inside this delegate changes as a result of scrolling,
  // so Flutter does not need to rebuild it during normal scrolling.
  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) {
    return false;
  }
}

// class _SearchHeader extends ConsumerWidget {
//   const _SearchHeader();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier =
//         ref.read(airtimeToCashHistoryProvider.notifier);

//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.fromLTRB(
//         8.w,
//         2.h,
//         8.w,
//         2.h,
//       ),
//       decoration: const BoxDecoration(
//         color: AppColors.white,
//         border: Border(
//           left: BorderSide(
//             color: AppColors.greyEE,
//           ),
//           right: BorderSide(
//             color: AppColors.greyEE,
//           ),
//           bottom: BorderSide(
//             color: AppColors.greyEE,
//           ),
//         ),
//       ),
//       child: AppTextField(
//         decoration: const InputDecoration().search(),
//         onChange: notifier.onSearchChanged,
//       ),
//     );
//   }
// }

/// Bottom section containing the transaction content.
class _RecentConversionsBottomCard extends StatelessWidget {
  const _RecentConversionsBottomCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
        border: const Border(
          left: BorderSide(color: AppColors.greyEE),
          right: BorderSide(color: AppColors.greyEE),
          bottom: BorderSide(color: AppColors.greyEE),
        ),
      ),
      child: const TransactionListWidget(limit: 5),
    );
  }
}

class _IntroCard extends StatefulWidget {
  const _IntroCard();

  @override
  State<_IntroCard> createState() => _IntroCardState();
}

class _IntroCardState extends State<_IntroCard> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.greyEE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Turn Airtime into Cash',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 22.sp,
                    color: AppColors.grey80,
                  ),
                ),
              ],
            ),
          ),

          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Convert your unused airtime to cash securely and conveniently.',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey80,
                      height: 1.45,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.greyF5,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const Row(
                      children: [
                        _FlowPill(label: 'Airtime', highlighted: true),
                        _FlowArrow(),
                        _FlowPill(label: 'Conversion'),
                        _FlowArrow(),
                        _FlowPill(label: 'Cash', highlighted: true),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    '    Fast processing • Secure • Transparent rates',
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: AppColors.primaryColor.withOpacity(.8),
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}

class _FlowPill extends StatelessWidget {
  const _FlowPill({required this.label, this.highlighted = false});

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 6.w),
        decoration: BoxDecoration(
          color: highlighted
              ? AppColors.primaryColor.withOpacity(0.08)
              : AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: highlighted
                ? AppColors.primaryColor.withOpacity(0.8)
                : AppColors.greyEE,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: 9.sp,
            color: highlighted ? AppColors.success : AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _FlowArrow extends StatelessWidget {
  const _FlowArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Icon(
        Icons.arrow_forward_rounded,
        size: 12.sp,
        color: AppColors.grey80,
      ),
    );
  }
}

class _ConvertFab extends StatelessWidget {
  const _ConvertFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      elevation: 5,
      icon: const Icon(Icons.add_rounded),
      label: const Text('Convert Airtime'),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.white,
      extendedPadding: EdgeInsets.symmetric(horizontal: 8.w),
    );
  }
}
