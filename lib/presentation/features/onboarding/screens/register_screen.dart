import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/phone_number_formatter.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/register_notifier.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with RestorationMixin {
  @override
  String? get restorationId => 'register_screen';

  // Use RestorableTextEditingController so Flutter restores selection/cursor too.
  final RestorableTextEditingController _restorableFirstName =
      RestorableTextEditingController();
  final RestorableTextEditingController _restorableLastName =
      RestorableTextEditingController();
  final RestorableTextEditingController _restorableEmail =
      RestorableTextEditingController();
  final RestorableTextEditingController _restorablePhone =
      RestorableTextEditingController();
  final RestorableTextEditingController _restorablePassword =
      RestorableTextEditingController();
  final RestorableTextEditingController _restorableConfirm =
      RestorableTextEditingController();
  // restore show/hide password toggles
  // final RestorableBool _restorableShowPassword = RestorableBool(false);
  // final RestorableBool _restorableShowConfirm = RestorableBool(false);

  // --- Guards to avoid infinite sync loops ----------------------------------
  // text sync guards
  bool _syncingFromProviderToRestorableText = false;
  bool _syncingFromRestorableToProviderText = false;

  // bool sync guard
  bool _syncingFromProviderToRestorableBool = false;
  bool _syncingFromRestorableToProviderBool = false;

  // Keep a reference to provider notifier if it exposes addListener/removeListener
  VoidCallback? _providerListener;
  // We'll keep a reference so we can remove it on dispose
  RegisterProvider? _registerNotifier;

  // Flag to track if we've initialized the sync
  bool _hasInitializedSync = false;
// Register restorable properties here
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_restorableFirstName, 'first_name');
    registerForRestoration(_restorableLastName, 'last_name');
    registerForRestoration(_restorableEmail, 'email');
    registerForRestoration(_restorablePhone, 'phone');
    registerForRestoration(_restorablePassword, 'password');
    registerForRestoration(_restorableConfirm, 'confirm');

    //  registerForRestoration(_restorableShowPassword, 'show_password');
    // registerForRestoration(_restorableShowConfirm, 'show_confirm');
  }

  @override
  void initState() {
    super.initState();
    _registerNotifier = ref.read(registerProvider);
    // Don't access restorable properties here - wait until after restoration
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Initialize sync only once, after restoration has completed
    if (!_hasInitializedSync) {
      _hasInitializedSync = true;
      _initializeSync();
    }
  }

  void _initializeSync() {
    final notifier = _registerNotifier!;

    //  text fields
    _wireTextSync(notifier.firstNameCtrl, _restorableFirstName);
    _wireTextSync(notifier.lastNameCtrl, _restorableLastName);
    _wireTextSync(notifier.emailCtrl, _restorableEmail);
    _wireTextSync(notifier.phoneCtrl, _restorablePhone);
    _wireTextSync(notifier.passwordCtrl, _restorablePassword);
    _wireTextSync(notifier.confirmCtrl, _restorableConfirm);

    // Wire up show password toggles (best-effort)
    // _wireBoolSync(notifier, 'showPassword', _restorableShowPassword,
    //     (n, v) => _setProviderShowPassword(n, v));
    // _wireBoolSync(notifier, 'showConfirm', _restorableShowConfirm,
    //     (n, v) => _setProviderShowConfirm(n, v));

    // Seed restorable controllers with provider values if restorable is empty.
    // This ensures that when the widget first appears with provider pre-filled fields,
    // the restorable controllers pick it up so future restores will reflect it.
    _seedRestorableIfEmpty(notifier.firstNameCtrl.text, _restorableFirstName);
    _seedRestorableIfEmpty(notifier.lastNameCtrl.text, _restorableLastName);
    _seedRestorableIfEmpty(notifier.emailCtrl.text, _restorableEmail);
    _seedRestorableIfEmpty(notifier.phoneCtrl.text, _restorablePhone);
    _seedRestorableIfEmpty(notifier.passwordCtrl.text, _restorablePassword);
    _seedRestorableIfEmpty(notifier.confirmCtrl.text, _restorableConfirm);

    // Also seed booleans
    // if (notifier.showPassword != _restorableShowPassword.value) {
    //   _restorableShowPassword.value = notifier.showPassword;
    // }
    // if (notifier.showConfirm != _restorableShowConfirm.value) {
    //   _restorableShowConfirm.value = notifier.showConfirm;
    // }

    // Add a provider-wide listener (if provider is a ChangeNotifier) to
    // update restorable booleans when provider toggles change.
    // We keep this generic and protective (try/catch) to avoid runtime errors.
    try {
      _providerListener = () {
        try {
          final n = _registerNotifier!;
          // update restorable bool if provider changed it
          // if (!_syncingFromRestorableToProviderBool) {
          //   final provShowPwd = n.showPassword;
          //   if (_restorableShowPassword.value != provShowPwd) {
          //     _syncingFromProviderToRestorableBool = true;
          //     _restorableShowPassword.value = provShowPwd;
          //     _syncingFromProviderToRestorableBool = false;
          //   }
          //   final provShowConfirm = n.showConfirm;
          //   if (_restorableShowConfirm.value != provShowConfirm) {
          //     _syncingFromProviderToRestorableBool = true;
          //     _restorableShowConfirm.value = provShowConfirm;
          //     _syncingFromProviderToRestorableBool = false;
          //   }
          // }
        } catch (_) {
          // ignore
        }
      };
      notifier.addListener(_providerListener!);
    } catch (_) {
      // provider might not support listeners — ignore
      _providerListener = null;
    }
  }

  // Helper: wire text controller ↔ restorable controller with guards
  void _wireTextSync(
    TextEditingController providerCtrl,
    RestorableTextEditingController restorable,
  ) {
    // When framework restores restorable, copy to provider (guarded)
    restorable.value.addListener(() {
      if (_syncingFromProviderToRestorableText) return;
      final restored = restorable.value.text;
      final providerText = providerCtrl.text;
      if (providerText != restored) {
        _syncingFromRestorableToProviderText = true;
        // use provider's controller to update text (this will update UI)
        providerCtrl.text = restored;
        _syncingFromRestorableToProviderText = false;
      }
    });

    // When provider updates (user typing), copy to restorable (guarded)
    providerCtrl.addListener(() {
      if (_syncingFromRestorableToProviderText) return;
      final providerText = providerCtrl.text;
      final restorableText = restorable.value.text;
      if (restorableText != providerText) {
        _syncingFromProviderToRestorableText = true;
        restorable.value.text = providerText;
        _syncingFromProviderToRestorableText = false;
      }
    });
  }

  // Helper: wire a provider-managed bool property ↔ restorable bool
  // - propName is only for debugging; setter is a callback to set the property on the provider.
  void _wireBoolSync(
    RegisterProvider notifier,
    String propName,
    RestorableBool restorable,
    void Function(RegisterProvider, bool) setOnProvider,
  ) {
    // When restorable toggles (user restored or user toggles), update provider
    restorable.addListener(() {
      if (_syncingFromProviderToRestorableBool) return;
      final val = restorable.value;
      try {
        _syncingFromRestorableToProviderBool = true;
        setOnProvider(notifier, val);
      } catch (_) {
        // ignore setter failure
      } finally {
        _syncingFromRestorableToProviderBool = false;
      }
    });

    // Provider -> restorable syncing is handled by the provider listener added in initState.
  }

  // Helper setters that attempt to set provider fields safely
  void _setProviderShowPassword(RegisterProvider? notifier, bool value) {
    if (notifier == null) return;
    try {
      // Best-effort: try to set property; if provider exposes a method prefer it.
      // Try method names commonly used; if not available, set field directly.
      if ((notifier as dynamic).setShowPassword != null) {
        (notifier as dynamic).setShowPassword(value);
      } else {
        (notifier as dynamic).showPassword = value;
      }
    } catch (_) {
      // ignore if provider doesn't have setter
      try {
        // try calling notify if available after direct mutation
        (notifier as dynamic).notifyListeners();
      } catch (_) {}
    }
  }

  void _setProviderShowConfirm(RegisterProvider? notifier, bool value) {
    if (notifier == null) return;
    try {
      if ((notifier as dynamic).setShowConfirm != null) {
        (notifier as dynamic).setShowConfirm(value);
      } else {
        (notifier as dynamic).showConfirm = value;
      }
    } catch (_) {
      try {
        (notifier as dynamic).notifyListeners();
      } catch (_) {}
    }
  }

  // Seed a restorable controller from provider text only if restorable is empty.
  void _seedRestorableIfEmpty(
    String providerValue,
    RestorableTextEditingController restorable,
  ) {
    try {
      if (restorable.value.text.isEmpty && providerValue.isNotEmpty) {
        restorable.value.text = providerValue;
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    try {
      // remove provider listener if added
      if (_providerListener != null && _registerNotifier != null) {
        try {
          _registerNotifier!.removeListener(_providerListener!);
        } catch (_) {}
      }
    } catch (_) {}

    // Dispose restorable properties (unregister automatically)
    _restorableFirstName.dispose();
    _restorableLastName.dispose();
    _restorableEmail.dispose();
    _restorablePhone.dispose();
    _restorablePassword.dispose();
    _restorableConfirm.dispose();

    // _restorableShowPassword.dispose();
    // _restorableShowConfirm.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(registerProvider);
    final ctrl = ref.read(registerProvider);
    return WillPopScope(
      onWillPop: () async {
        debugPrint('onWillPop pressed -> navigate to walkthrough');
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   context.go(RouteConstants.walkThrough);
        // });
        if (mounted) {
          context.pop();
        }
        return false;
      },
      child: BundlegramScaffold(
        resizeToAvoidBottomInset: true,
        sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
        appBar: BundlegramAppbar(
            showBackButton: true,
            onTap: () {
              HapticFeedback.lightImpact();
              if (mounted) {
                context.pop();
              }
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   context.go(RouteConstants.walkThrough);
              // });
            }),
        body: Column(
          children: [
            Column(
              children: [
                Text(
                  "Let's get started!",
                  style: context.textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account? ',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.grey33,
                        // fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        context.go('/login');
                        // context.push('/login');
                      },
                      child: Text(
                        'Sign in.',
                        style: context.textTheme.bodyMedium!.copyWith(
                          // fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            40.verticalSpace,
            Expanded(
              child: AppForm(
                formKey: ctrl.formKey,
                isActive: prov.isValid && !prov.isLoading,
                buttonText: prov.isLoading ? 'Loading...' : 'Continue',
                onPressed: () => ctrl.submit(context),
                children: [
                  AppTextField(
                    hintText: 'First name',
                    controller: ctrl.firstNameCtrl,
                    validateFunction: Validators.name(),
                    textInputAction: TextInputAction.next,
                  ),
                  AppTextField(
                    hintText: 'Last name',
                    controller: ctrl.lastNameCtrl,
                    validateFunction: Validators.name(),
                    textInputAction: TextInputAction.next,
                  ),
                  AppTextField(
                    hintText: 'Email address',
                    controller: ctrl.emailCtrl,
                    validateFunction: Validators.email(),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  AppTextField(
                    hintText: 'Phone number',
                    controller: ctrl.phoneCtrl,
                    validateFunction: Validators.validateNigerianPhoneNumber(),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      NumberInputFormatter(),
                      LengthLimitingTextInputFormatter(
                        10,
                      ), // Limits input to 10 digits
                    ],
                    prefixIcon: Padding(
                      padding: context.symmetricPadding(20, 12),
                      child: Text('+234', style: context.textTheme.bodySmall),
                    ),
                  ),
                  AppTextField(
                    hintText: 'Password',
                    controller: ctrl.passwordCtrl,
                    validateFunction: Validators.password(),
                    // Add simple required validation
                    // validateFunction: (value) {
                    //   if (value == null || value.trim().isEmpty) {
                    //     return 'Password is required';
                    //   }
                    //   return null;
                    // },
                    obscureText: !prov.showPassword,
                    suffixIcon: GestureDetector(
                      onTap: () => setState(
                          () => prov.showPassword = !prov.showPassword),
                      child: Icon(
                        prov.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.grey33,
                        size: 24,
                      ),
                    ),
                  ),
                  AppTextField(
                    hintText: 'Confirm Password',
                    controller: ctrl.confirmCtrl,
                    // onChange: Validators.confirmPass(ctrl.passwordCtrl.text.trim()),
                    // Add simple required validation and basic confirm password check
                    validateFunction: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Confirm Password is required';
                      }
                      if (value.trim() != ctrl.passwordCtrl.text.trim()) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: !prov.showConfirm,
                    onChange: (value) {
                      ctrl.validate();
                    },
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          setState(() => prov.showConfirm = !prov.showConfirm),
                      child: Icon(
                        prov.showConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.grey33,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            40.verticalSpace,
            RichText(
              text: TextSpan(
                text: 'By continuing, you agree to the ',
                style: context.textTheme.bodySmall,
                children: [
                  TextSpan(
                    text: 'Terms and Conditions',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.push(RouteConstants.termsCondition);
                        ctrl.markTermsTapped();
                      },
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const TextSpan(text: ' and'),
                  TextSpan(
                    text: ' Privacy Policy',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.push(RouteConstants.privacyPolicy);
                        ctrl.markPrivacyTapped();
                      },
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primaryColor,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
