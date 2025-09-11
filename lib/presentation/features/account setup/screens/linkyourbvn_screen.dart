import 'dart:developer';

import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/link_bvn_provider.dart';
import 'package:bundlegram/presentation/features/transaction/screens/widgets/transaction_success_widget.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_datetextfield.dart';
import 'package:bundlegram/presentation/general_widget/app_dropdown.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class LinkyourbvnScreen extends StatelessWidget {
//   const LinkyourbvnScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BundlegramScaffold(
//       appBar: const BundlegramAppbar(
//         titleText: 'Link your BVN',
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const AppTextField(
//               hintText: 'Bank Verification Number (BVN)',
//             ),
//             20.verticalSpace,
//             const AppTextField(
//               hintText: 'Phone Number linked to BVN',
//             ),
//             20.verticalSpace,
//             const AppTextField(
//               hintText: 'Date of birth (DD/MM/YY)',
//             ),
//             20.verticalSpace,
//             const Text('Add bank details of a linked account'),
//             18.verticalSpace,
//             const AppDropdown(title: 'Bank name'),
//             20.verticalSpace,
//             const AppTextField(
//               hintText: 'Account number',
//             ),
//             20.verticalSpace,
//             const AppTextField(
//               hintText: 'Account name',
//             ),
//             40.verticalSpace,
//             BundlegramButton(
//               text: 'Submit detail',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (ctx) => const TransactionSuccessful(
//                       isBasicInfo: true,
//                       title: 'BVN Linked!',
//                       subTitle:
//                           'Your BVN has been successfully linked to your Bundlegram account. We will notify you once verified.',
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LinkYourBvnScreen extends ConsumerWidget {
  const LinkYourBvnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(linkBvnProvider);
    final notifier = ref.read(linkBvnProvider.notifier);

    // assume banks list comes from globalProvider via notifier.bankOptions
    // final banks = notifier.bankOptions;
    final banksAsync = ref.watch(globalProvider).banks;

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Link your BVN'),
      body: Form(
        key: provider.formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return RefreshIndicator(
              onRefresh: () async {
                try {
                  // Prefer calling the notifier's method directly so there is no race with ref.refresh(...)
                  await ref.read(globalProvider.notifier).fetchBanks(context);
                  // Optionally, if you want to force provider re-evaluation:
                  // ref.invalidate(globalProvider); // Riverpod v2 style
                } catch (err, st) {
                  // log error but don't crash the UI
                  log('refresh banks failed: $err', stackTrace: st);
                }
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Ensure the phone number and date of birth provided are the same as those registered with your BVN.',
                          textAlign: TextAlign.left,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AppTextField(
                          label: 'Bank Verification Number (BVN)',
                          controller: notifier.bvn,
                          hintText: 'Bank Verification Number (BVN)',
                          validateFunction: notifier.validateBVN,
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          label: 'Phone Number',
                          controller: notifier.phone,
                          hintText: 'Phone Number linked to BVN',
                          validateFunction: notifier.validatePhone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                                11), // stop at 11 digits
                          ],
                        ),
                        SizedBox(height: 20.h),
                        AppDatetextfield(
                          controller: notifier.dob,
                          title: '',
                          hintText: 'Date of birth(DD/MM/YYYY)',
                          validator: notifier.validateDate,
                          onTap: () => notifier.pickDob(context),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Add bank details of a linked account',
                          textAlign: TextAlign.left,
                          style: context.textTheme.bodyMedium,
                        ),
                        SizedBox(height: 16.h),
                        // AppDropdown(
                        //   title: provider.selectedBankName == ""
                        //       ? "Bank Name"
                        //       : provider.selectedBankName,
                        //   options: banks,
                        //   selected: provider.selectedBankName,
                        //   onChanged: notifier.setBank,
                        // ),
                        // Banks Async UI
                        banksAsync.when(
                          data: (banksData) {
                            final banks = notifier.bankOptions;
                            return AppDropdown(
                              title: provider.selectedBankName == ""
                                  ? "Bank Name"
                                  : provider.selectedBankName,
                              options: banks,
                              selected: provider.selectedBankName,
                              onChanged: notifier.setBank,
                            );
                          },
                          loading: () => const Align(
                            alignment: Alignment.centerLeft,
                            child: PulsingDotsLoader(
                              loadingMessage: "Loading banks...",
                            ),
                          ),
                          error: (err, st) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              PulsingDotsLoader(
                                loadingMessage: "Refreshing banks...",
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Pull down to retry",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          label: 'Account Number',
                          controller: notifier.acct,
                          hintText: 'Account number',
                          validateFunction: notifier.validateAccount,
                          onChange: notifier.onAccountNumberChanged,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                                10), // stop at 10 digits
                          ],
                        ),
                        if (provider.fetchingName) ...[
                          SizedBox(height: 16.h),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: PulsingDotsLoader(
                                loadingMessage: "Fetching account name..."),
                          ),
                        ],
                        SizedBox(height: 16.h),
                        AppTextField(
                          label: 'Account Name',
                          controller:
                              TextEditingController(text: provider.acctName),
                          hintText: 'Account name',
                          readOnly: true,
                        ),
                        SizedBox(height: 32.h),
                        BundlegramButton(
                          text: 'Submit detail',
                          onPressed: provider.loading
                              ? null
                              : () => notifier.submit(context),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PulsingDotsLoader extends StatefulWidget {
  final String loadingMessage;
  const PulsingDotsLoader({Key? key, required this.loadingMessage})
      : super(key: key);

  @override
  State<PulsingDotsLoader> createState() => _PulsingDotsLoaderState();
}

class _PulsingDotsLoaderState extends State<PulsingDotsLoader>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Opacity(
                  opacity: 0.3 + (_animations[index].value * 0.7),
                  child: Transform.scale(
                    scale: 0.5 + (_animations[index].value * 0.5),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
        const SizedBox(width: 8),
        Text(
          widget.loadingMessage,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
