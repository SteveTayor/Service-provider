import 'dart:async';
import 'dart:developer';

import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/link_bvn_provider.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/bvn_diaclaimer/disclaimer.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/bvn_diaclaimer/privacy_disclaimer.dart';
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
import 'package:go_router/go_router.dart';

class LinkYourBvnScreen extends ConsumerStatefulWidget {
  const LinkYourBvnScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LinkYourBvnScreen> createState() => _LinkYourBvnScreenState();
}

class _LinkYourBvnScreenState extends ConsumerState<LinkYourBvnScreen>
    with WidgetsBindingObserver {
  bool _isShowingFetchingDialog = false;
  bool _hasShownDisclaimer = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Run async fetches after first frame, but guard with try/catch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() async {
        // Show privacy disclaimer first
        if (!_hasShownDisclaimer) {
          unawaited(_showPrivacyDisclaimer());
        }
        try {
          await ref.read(globalProvider.notifier).fetchBanks(context);
        } catch (e, st) {
          log('fetchBanks failed in LinkYourBvnScreen: $e', stackTrace: st);
        }
        try {
          await ref.read(globalProvider.notifier).fetchProfile(context);
        } catch (e, st) {
          log('fetchProfile failed in LinkYourBvnScreen: $e', stackTrace: st);
        }
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Future.microtask(() async {
        if (!mounted) return;

        try {
          await ref.read(globalProvider.notifier).fetchBanks(context);
          await ref.read(globalProvider.notifier).fetchProfile(context);
        } catch (_) {}
      });
    }
  }

  @override
  void dispose() {
    // If dialog is still shown for some reason, dismiss it when disposing
    WidgetsBinding.instance.removeObserver(this);
    if (_isShowingFetchingDialog && mounted) {
      Navigator.of(context, rootNavigator: true).maybePop();
    }
    super.dispose();
  }

  Future<void> _showPrivacyDisclaimer() async {
    if (!mounted) return;

    _hasShownDisclaimer = true;
    final shouldContinue = await context.showBottomSheet<bool>(
      child: const PrivacyDisclaimerWidget(),
      isDismissible: false,
      // showDragHandle: true,
    );

    // If user dismisses or chooses not to continue, navigate back
    if (shouldContinue != true && mounted) {
      Navigator.of(context).pop();
    }
  }

  // void _maybeShowOrHideFetchingDialog(
  //     bool fetching, TextEditingController acctController) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (!mounted) return;

  //     final acctLen = acctController.text.trim().length;
  //     final shouldShow = fetching && acctLen == 10;

  //     if (shouldShow && !_isShowingFetchingDialog) {
  //       _isShowingFetchingDialog = true;
  //       context.showLoadingDialog(message: "Fetching account name...");
  //     } else if (!shouldShow && _isShowingFetchingDialog) {
  //       context.dismissDialog();
  //       _isShowingFetchingDialog = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(linkBvnProvider); // state
    final notifier =
        ref.read(linkBvnProvider.notifier); // notifier (actions/controllers)

    // assume banks list comes from globalProvider via notifier.bankOptions
    // final banks = notifier.bankOptions;
    final banksAsync = ref.watch(globalProvider).banks;
    final profileAsync = ref.watch(globalProvider).profile;

    final bool isGlobalLoading = banksAsync.isLoading || profileAsync.isLoading;

    ref.listen(linkBvnProvider, (prev, next) {
      final acctLen = notifier.acct.text.trim().length;
      final shouldShow = next.fetchingName && acctLen == 10;

      if (shouldShow && !_isShowingFetchingDialog) {
        _isShowingFetchingDialog = true;
        context.showLoadingDialog(message: "Fetching account name...");
      } else if (!shouldShow && _isShowingFetchingDialog) {
        context.dismissDialog();
        _isShowingFetchingDialog = false;
      }
    });

    return BundlegramScaffold(
      resizeToAvoidBottomInset: true,
      appBar: const BundlegramAppbar(titleText: 'Link your BVN'),
      body: isGlobalLoading
          ? const Center(
              child: PulsingDotsLoader(
                loadingMessage: "Preparing BVN verification...",
              ),
            )
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: provider.formKey,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        try {
                          // Prefer calling the notifier's method directly so there is no race with ref.refresh(...)
                          await ref
                              .read(globalProvider.notifier)
                              .fetchBanks(context);
                          // Optionally, if you want to force provider re-evaluation:
                          // ref.invalidate(globalProvider); // Riverpod v2 style
                        } catch (err, st) {
                          // log error but don't crash the UI
                          log('refresh banks failed: $err', stackTrace: st);
                        }
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        loadingMessage:
                                            "Fetching account name..."),
                                  ),
                                ],
                                SizedBox(height: 16.h),
                                AppTextField(
                                  label: 'Account Name',
                                  controller: TextEditingController(
                                      text: provider.acctName),
                                  hintText: 'Account name',
                                  readOnly: true,
                                ),
                                SizedBox(height: 32.h),
                                BundlegramButton(
                                  text: 'Verify BVN',
                                  onPressed: provider.loading
                                      ? null
                                      : () => notifier.submit(context),
                                  // : () {
                                  //     // Optional: check a persisted flag so you don't show it if user opted out
                                  //     context.showBottomSheet(
                                  //       child: BvnDisclaimerBottomSheet(
                                  //         onConfirm: () {
                                  //           // note: sheet will already be popped when this runs
                                  //           notifier.submit(context);
                                  //         },
                                  //         onViewPrivacyPolicy: () {
                                  //           // navigate to privacy page or open a webview
                                  //           context.push(
                                  //               RouteConstants.privacyPolicy);
                                  //         },
                                  //       ),
                                  //       isDismissible: true,
                                  //       // showDragHandle: true,
                                  //     );
                                  //   },
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
