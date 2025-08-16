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
  final Widget child;
  const InactivityWrapper({super.key, required this.child});

  @override
  ConsumerState<InactivityWrapper> createState() => _InactivityWrapperState();
}

class _InactivityWrapperState extends ConsumerState<InactivityWrapper>
    with WidgetsBindingObserver {
  Timer? _inactivityTimer;
  DateTime _lastInteraction = DateTime.now();
  final _timeoutDuration = const Duration(minutes: 5);
  final FocusNode _keyboardFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _keyboardFocusNode.requestFocus(); // so RawKeyboardListener can work
    _initializeTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    _keyboardFocusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _initializeTimer() async {
    _cancelTimer();

    // Only start timer if authenticated
    final secureStorage = ref.read(secureStorageHelperProvider);
    final token = await secureStorage.getAuthToken();
    if (token == null || token.isEmpty) return;

    _inactivityTimer = Timer(_timeoutDuration, _handleTimeout);
  }

  void _cancelTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  void _handleUserInteraction([_]) {
    _lastInteraction = DateTime.now();
    _initializeTimer();
  }

  Future<void> _handleTimeout() async {
    final secureStorage = ref.read(secureStorageHelperProvider);
    await secureStorage.deleteAuthToken();

    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    if (!currentRoute.contains(RouteConstants.login)) {
      // ctx.showCustomSnackBar('Logged out due to inactivity.');
      unawaited(Future.microtask(() => ctx.go(RouteConstants.login)));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      _lastInteraction = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      if (DateTime.now().difference(_lastInteraction) > _timeoutDuration) {
        _handleTimeout();
      } else {
        _initializeTimer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _keyboardFocusNode,
      onKeyEvent: (_) => _handleUserInteraction(),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleUserInteraction,
        onPointerMove: _handleUserInteraction,
        onPointerUp: _handleUserInteraction,
        child: widget.child,
      ),
    );
  }
}
