import 'dart:async';
import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InactivityWrapper extends ConsumerStatefulWidget {
  const InactivityWrapper({
    super.key,
    required this.child,
    this.timeoutDuration = const Duration(minutes: 10),
  });

  final Widget child;

  /// How long the app can sit idle before locking/logging out. Exposed as a
  /// constructor param (rather than a hardcoded const) so widget tests can
  /// pass a short duration instead of waiting out the real timeout.
  final Duration timeoutDuration;

  @override
  ConsumerState<InactivityWrapper> createState() => _InactivityWrapperState();
}

class _InactivityWrapperState extends ConsumerState<InactivityWrapper>
    with WidgetsBindingObserver {
  Timer? _inactivityTimer;
  DateTime _lastInteraction = DateTime.now();
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Focus-independent: fires regardless of which widget currently has
    // focus, so typing into a TextField still resets the timer. A
    // KeyboardListener tied to a local FocusNode would go silent the
    // moment focus moves to any text field elsewhere in the app.
    HardwareKeyboard.instance.addHandler(_handleHardwareKeyEvent);
    _initializeTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    HardwareKeyboard.instance.removeHandler(_handleHardwareKeyEvent);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Resets the timer to [widget.timeoutDuration] from now.
  void _initializeTimer() {
    _cancelTimer();
    _inactivityTimer = Timer(widget.timeoutDuration, _handleTimeout);
  }

  void _cancelTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  bool _handleHardwareKeyEvent(KeyEvent event) {
    _handleUserInteraction();
    return false; // don't consume the event — just observe it
  }

  /// Called on any user interaction.
  void _handleUserInteraction([_]) {
    _lastInteraction = DateTime.now();
    _initializeTimer();
  }

  /// Handles inactivity logout/lock.
  Future<void> _handleTimeout() async {
    if (_isLoggingOut) return; // prevent multiple triggers
    _isLoggingOut = true;

    try {
      final ctx = navigatorKey.currentContext;
      if (ctx == null) return;

      // Read secure storage to decide whether the app had saved
      // credentials worth locking (vs. forcing a full re-login).
      final secureStorage = ref.read(secureStorageHelperProvider);

      String? rememberedEmail;
      bool hasBiometric = false;
      try {
        rememberedEmail = await secureStorage.getRememberedEmail();
        hasBiometric = await secureStorage.hasBiometricCredentials();
      } catch (e) {
        // If secure storage fails for any reason, fall back to forcing
        // login (safer default than assuming saved state exists).
        rememberedEmail = null;
        hasBiometric = false;
      }

      final bool hasSavedState =
          (rememberedEmail != null && rememberedEmail.isNotEmpty) ||
          hasBiometric;

      final currentRoute = ModalRoute.of(ctx)?.settings.name ?? '';

      if (hasSavedState) {
        // Already on lock screen — nothing to do.
        if (!currentRoute.contains(RouteConstants.lockScreen)) {
          ctx
            ..go(RouteConstants.lockScreen)
            ..showErrorSnackBar('Locked out due to inactivity.');
        }
      } else {
        // Nothing to restore — route to login instead of lock screen.
        if (!currentRoute.contains(RouteConstants.login)) {
          ctx.go(RouteConstants.login);
        }
      }
    } catch (e) {
      // Last-resort: log and attempt to navigate to login.
      debugPrint('Error during inactivity logout: $e');
      final ctx = navigatorKey.currentContext;
      if (ctx != null &&
          !(ModalRoute.of(ctx)?.settings.name ?? '').contains(
            RouteConstants.login,
          )) {
        ctx
          ..go(RouteConstants.login)
          ..showErrorSnackBar('Session expired.');
      }
    } finally {
      _isLoggingOut = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      _lastInteraction = DateTime.now();
      // Stop the foreground timer — the resume-time elapsed check below
      // is the single source of truth for what happens next
      _cancelTimer();
    } else if (state == AppLifecycleState.resumed) {
      if (DateTime.now().difference(_lastInteraction) >
          widget.timeoutDuration) {
        _handleTimeout();
      } else {
        _initializeTimer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handleUserInteraction,
      onPointerMove: _handleUserInteraction,
      onPointerUp: _handleUserInteraction,
      child: widget.child,
    );
  }
}
