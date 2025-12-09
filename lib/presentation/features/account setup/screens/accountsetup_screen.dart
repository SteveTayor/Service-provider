import 'dart:developer';
import 'dart:math' as math;

import 'package:bundlegram/presentation/features/account%20setup/notifier/account_setup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:confetti/confetti.dart';

class AccountsetupScreen extends ConsumerStatefulWidget {
  const AccountsetupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountsetupScreen> createState() => _AccountsetupScreenState();
}

class _AccountsetupScreenState extends ConsumerState<AccountsetupScreen> {
  late ConfettiController _confettiControllerTop;
  late ConfettiController _confettiControllerBottom;
  bool _hasCelebrated = false;

  @override
  void initState() {
    super.initState();

    _confettiControllerTop =
        ConfettiController(duration: const Duration(seconds: 2));
    _confettiControllerBottom =
        ConfettiController(duration: const Duration(seconds: 2));

    // fetch banks once on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // run in a microtask so we can use async/await safely
      Future.microtask(() async {
        try {
          await ref.read(globalProvider.notifier).fetchBanks(context);
        } catch (e, st) {
          // log but do not rethrow — prevents framework error overlay
          log('fetchBanks() failed in AccountsetupScreen: $e', stackTrace: st);
        }
        try {
          await ref.read(globalProvider.notifier).fetchProfile(context);
        } catch (e, st) {
          log('fetchProfile() failed in AccountsetupScreen: $e',
              stackTrace: st);
        }
      });
    });
  }

  @override
  void dispose() {
    _confettiControllerTop.dispose();
    _confettiControllerBottom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(accountSetupProvider);
    final steps = provider.steps;
    final profileAsync = ref.watch(globalProvider).profile;
    String firstName = '';
    try {
      firstName = profileAsync.value?.data?.firstName ?? '';
    } catch (_) {
      firstName = '';
    }

    // detect if all steps are completed
    final allDone = steps.isNotEmpty && steps.every((s) => s.done);

    // Trigger celebration once when allDone becomes true
    if (allDone && !_hasCelebrated) {
      _hasCelebrated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _confettiControllerTop.play();
          _confettiControllerBottom.play();
        }
      });
    }

    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Complete account set up',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // If finished show Hurray animation + message,
                // otherwise show the original instructional text.
                if (allDone)
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.8, end: 1.0),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.elasticOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          'All done! 🎉',
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        8.verticalSpace,
                        Text(
                          'Your account setup is complete. You can now enjoy Bundlegram fully.',
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                else
                  Text(
                    'Hi ${firstName.isNotEmpty ? firstName : 'there'}, finish setting up your account to enjoy Bundlegram fully.',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium,
                  ),

                24.verticalSpace,
                // Progress indicator bar
                SizedBox(
                  height: 10.h,
                  child: Row(
                    children: steps.map((step) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: step.done
                                ? AppColors.primaryColor
                                : AppColors.greyd9,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                48.verticalSpace,
                // Step list
                Column(
                  children: steps.map((step) {
                    return InkWell(
                      onTap: step.done
                          ? null
                          : () => provider.onStepTap(step, context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppSvgIcon(path: step.asset),
                          12.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(step.title,
                                    style: context.textTheme.bodyMedium),
                                8.verticalSpace,
                                Text(step.label,
                                    style: context.textTheme.labelMedium),
                              ],
                            ),
                          ),
                          AppSvgIcon(
                            path: step.done
                                ? Assets.svgs.check
                                : Assets.svgs.unveirifycheck,
                          ),
                        ],
                      ).withContainer(
                        padding: context.symmetricPadding(0, 8),
                        margin: EdgeInsets.only(bottom: 24.h),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // CONFETTI TOP (explodes downward)
          Align(
            alignment: Alignment.topCenter,
            child: IgnorePointer(
              ignoring: true,
              child: ConfettiWidget(
                confettiController: _confettiControllerTop,
                blastDirection: math.pi / 2, // downward
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                maxBlastForce: 20,
                minBlastForce: 8,
                gravity: 0.3,
              ),
            ),
          ),

          // CONFETTI BOTTOM (explodes upward for symmetric effect)
          Align(
            alignment: Alignment.bottomCenter,
            child: IgnorePointer(
              ignoring: true,
              child: ConfettiWidget(
                confettiController: _confettiControllerBottom,
                blastDirection: -math.pi / 2, // upward
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                emissionFrequency: 0.05,
                numberOfParticles: 18,
                maxBlastForce: 18,
                minBlastForce: 6,
                gravity: 0.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
