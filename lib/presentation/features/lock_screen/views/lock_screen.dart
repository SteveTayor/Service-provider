import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bundlegram/core/extensions/biometric_extension_helper.dart';
import 'package:bundlegram/core/extensions/dialog_extensions.dart';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/providers/global_provider.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/biometric/providers/biometric_service.dart';
import 'package:bundlegram/presentation/features/lock_screen/provider/lock_screen_provider.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/login_notifier.dart';
import 'package:bundlegram/presentation/features/setting/provider/security_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

extension TimeGreeting on DateTime {
  String getGreeting() {
    final hour = this.hour;
    if (hour >= 0 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
}

class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({
    super.key,
  });

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _pin = ['', '', '', ''];
  int _currentIndex = 0;
  String? _errorMessage;
  DateTime? _lastBack;
  String? _displayName;
  bool _autoAuthAttempted = false;

  late AnimationController _shakeController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);

    _loadCachedName();
    Future.microtask(() {
      if (!mounted) return;
      _tryAutoAuthenticate();
    });
  }

  // --- attempt biometric automatically if enabled ---
  Future<void> _tryAutoAuthenticate() async {
    if (_autoAuthAttempted) return;
    _autoAuthAttempted = true;

    final security = ref.read(securityProvider);
    final showBiometric = security.useFingerprint || security.useFaceId;
    if (!showBiometric) return;

    final biometricService = ref.read(biometricServiceProvider);

    try {
      debugPrint('[Biometric] Auto attempt starting...');
      final didAuth = await biometricService.authenticate(
        biometricHint: '',
        type: BiometricAuthType.login,
      );

      debugPrint('[Biometric] Auto attempt result: $didAuth');

      if (!mounted) return;

      if (didAuth) {
        final storage = ref.read(secureStorageHelperProvider);
        final email = await storage.getSafeEmail();
        final password = await storage.getBiometricPassword();
        final storedPin = email != null ? await storage.getPin(email) : null;
        if (storedPin != null) {
          await _simulatePinEntry(storedPin);
        }

        unawaited(context.showLoadingDialog());
        final didRestore =
            await ref.read(globalProvider.notifier).restoreSession(context);
        if (didRestore) {
          context.dismissDialog();
          if (mounted) context.go(RouteConstants.dashboard);
          return;
        }

        if (email != null && password != null) {
          final lockService = ref.read(lockScreenServiceProvider);
          await lockService.performLogin(
            email,
            password,
            context,
          );
          context.dismissDialog();
          if (mounted) {
            context.go(RouteConstants.dashboard);
            return;
          }
        }

        debugPrint(
            'Biometric authenticated but credentials missing. Please use PIN.');
      } else {
        debugPrint('[Biometric] Auto auth failed or cancelled by user.');
      }
    } catch (e, st) {
      debugPrint('[Biometric] Auto auth exception: $e\n$st');
    }
  }

  Future<void> _loadCachedName() async {
    final storage = ref.read(secureStorageHelperProvider);
    final username = await storage.getUsername();
    final email = await storage.getRememberedEmail();

    setState(() {
      _displayName = username ?? email ?? 'User';
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _updatePin(String value) {
    if (_currentIndex < 4) {
      setState(() {
        _pin[_currentIndex] = value;
        _currentIndex++;
      });
      if (_currentIndex == 4) {
        final enteredPin = _pin.join();
        _verifyPin(enteredPin);
      }
    }
  }

  void _deletePin() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pin[_currentIndex] = '';
      });
    }
  }

  Future<void> _simulatePinEntry(String storedPin) async {
    setState(() {
      _pin.fillRange(0, 4, '');
      _currentIndex = 0;
    });

    for (int i = 0; i < storedPin.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      setState(() {
        _pin[_currentIndex] = storedPin[i];
        _currentIndex++;
      });
    }

    final enteredPin = _pin.join();
  }

  Future<void> _verifyPin(String enteredPin) async {
    final storage = ref.read(secureStorageHelperProvider);

    final userEmail = await storage.getSafeEmail();
    if (userEmail == null) {
      setState(() {
        _errorMessage = 'User not authenticated. Please log in.';
        _currentIndex = 0;
        _pin.fillRange(0, 4, '');
      });
      unawaited(_shakeController.forward(from: 0));
      return;
    }

    final storedPin = await storage.getPin(userEmail);
    if (storedPin == enteredPin) {
      final password = await storage.getPassword();
      if (password == null) {
        debugPrint('[Password stored] stored password is $password');
        context
          ..showErrorSnackBar('Password not found, please login again')
          ..go(RouteConstants.login);
        return;
      }

      final lockService = ref.read(lockScreenServiceProvider);
      await lockService.performLogin(userEmail, password, context);
    } else {
      setState(() {
        _errorMessage = 'Incorrect PIN';
        _currentIndex = 0;
        _pin.fillRange(0, 4, '');
      });
      unawaited(_shakeController.forward(from: 0));
    }
  }

  Widget _buildPinDot(int index) {
    return Container(
      width: 24.w,
      height: 24.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _pin[index].isNotEmpty
            ? AppColors.primaryColor
            : Colors.transparent,
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return TextButton(
      onPressed: () {
        setState(() => _errorMessage = null);
        _updatePin(number);
      },
      style: TextButton.styleFrom(padding: EdgeInsets.all(16.w)),
      child: Text(
        number,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalUserProvider = ref.watch(globalProvider).profile;
    final profileProv = globalUserProvider.value?.data;
    final security = ref.watch(securityProvider);

    final showBiometric = security.useFingerprint || security.useFaceId;

    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();

        if (_lastBack == null ||
            now.difference(_lastBack!) > const Duration(seconds: 3)) {
          _lastBack = now;
          context.showCustomSnackBar(
            'Press back again to exit',
          );
          return false;
        }

        return true;
      },
      child: PopScope(
        canPop: false,
        child: BundlegramScaffold(
          sidePadding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  // Image(
                  //   image: Assets.images.bBundlegram.provider(),
                  //   fit: BoxFit.contain,
                  // ).withContainer(
                  //   height: 34.h,
                  // ),

                  // Top section with logo and greeting
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppSvgIcon(
                          path: Assets.svgs.lockIcon,
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        Text(
                          '${DateTime.now().getGreeting()}, ${profileProv?.username ?? _displayName ?? "User"}',
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.01),
                        Text(
                          Platform.isIOS
                              ? '${showBiometric ? "Use Face ID or" : ""} Enter account pin'
                              : '${showBiometric ? "Verify fingerprint or" : ""} Enter account pin',
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: AppColors.grey33,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Middle section with PIN dots
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _shakeController,
                          builder: (context, child) {
                            final offset = sin(_offsetAnimation.value) * 12;
                            return Transform.translate(
                              offset: Offset(offset, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, _buildPinDot),
                              ),
                            );
                          },
                        ),
                        if (_errorMessage != null) ...[
                          SizedBox(height: 8.h),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: AppColors.errorText,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Number pad - responsive
                  Flexible(
                    flex: 3,
                    child: Center(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        children: [
                          ...List.generate(
                            9,
                            (index) => _buildNumberButton('${index + 1}'),
                          ),
                          if (showBiometric) ...[
                            GestureDetector(
                              onTap: () async {
                                _autoAuthAttempted = false;
                                await _tryAutoAuthenticate();
                                // final biometricService =
                                //     ref.read(biometricServiceProvider);
                                // final storage =
                                //     ref.read(secureStorageHelperProvider);
                                // debugPrint(
                                //     '[Biometric] Starting authentication...');
                                // final didAuth =
                                //     await biometricService.authenticate(
                                //   biometricHint: '',
                                //   type: BiometricAuthType.login,
                                // );
                                // debugPrint(
                                //     '[Biometric] Authentication result: $didAuth');
                                // if (didAuth) {
                                //   final storage =
                                //       ref.read(secureStorageHelperProvider);
                                //   final email = await storage.getSafeEmail();
                                //   final token = await storage.getAuthToken();
                                //   final storedPin = email != null
                                //       ? await storage.getPin(email)
                                //       : null;
                                //   debugPrint(
                                //       '[Biometric] Retrieved email: $email');
                                //   debugPrint(
                                //       '[Biometric] Retrieved token: $token');
                                //   debugPrint(
                                //       '[Biometric] Retrieved storedPin: $storedPin');
                                //   if (token != null) {
                                //     debugPrint(
                                //         '[Biometric] Token exists → restoring session');
                                //     await _simulatePinEntry(
                                //         storedPin.toString());
                                //     //  Restore existing session, no new login
                                //     unawaited(context.showLoadingDialog());
                                //     await ref
                                //         .read(globalProvider.notifier)
                                //         .restoreSession(context);
                                //     debugPrint(
                                //         '[Biometric] Session restored, navigating to dashboard');
                                //     context
                                //       ..dismissDialog()
                                //       ..go(RouteConstants.dashboard);
                                //   } else {
                                //     // fallback: use saved biometric credentials
                                //     debugPrint(
                                //         '[Biometric] No token found → using saved credentials');
                                //     final email = await storage.getSafeEmail();
                                //     final password = await storage
                                //         .getBiometricPassword(); // still biometric only
                                //     final storedPin = email != null
                                //         ? await storage.getPin(email)
                                //         : null;
                                //     debugPrint(
                                //         '[Biometric] Retrieved password: $password');
                                //     debugPrint(
                                //         '[Biometric] Retrieved storedPin (fallback): $storedPin');
                                //     debugPrint(
                                //         '[Biometric] Retrieved password: $password');
                                //     debugPrint(
                                //         '[Biometric] Retrieved storedPin (fallback): $storedPin');
                                //     if (email != null && password != null) {
                                //       // simulate UI filling the pin before continuing
                                //       debugPrint(
                                //           '[Biometric] Credentials available → performing login');
                                //       await _simulatePinEntry(
                                //           storedPin.toString());
                                //       final lockService =
                                //           ref.read(lockScreenServiceProvider);
                                //       await lockService.performLogin(
                                //           email, password, context);
                                //       debugPrint(
                                //           '[Biometric] Login completed with email/password');
                                //     } else {
                                //       debugPrint(
                                //           '[Biometric] Missing biometric credentials → showing error');
                                //       context.showErrorSnackBar(
                                //         'Biometric credentials not found, please USE PIN',
                                //       );
                                //     }
                                //   }
                                // } else {
                                //   debugPrint(
                                //       '[Biometric] Authentication failed → showing error');
                                //   context.showErrorSnackBar(
                                //       'Biometric authentication failed');
                                // }
                              },
                              child: Container(
                                padding: EdgeInsets.all(20.w),
                                child: AppSvgIcon(
                                  path: Assets.svgs.fingerCricle1,
                                  fit: BoxFit.scaleDown,
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                          ] else ...[
                            const SizedBox.shrink(),
                          ],
                          _buildNumberButton('0'),
                          IconButton(
                            onPressed: _deletePin,
                            icon: const Icon(
                              Icons.backspace_outlined,
                              size: 24,
                              color: AppColors.grey83,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom section with switch account and sign in options
                  Flexible(
                    flex: 1,
                    child: Column(
                      // spacing: 10.h,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                context.go(RouteConstants.walkThrough);
                              },
                              child: Text(
                                'Switch account',
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.go(RouteConstants.login);
                              },
                              child: Text(
                                'Sign in with password',
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
