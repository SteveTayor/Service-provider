import 'dart:async';

import 'package:bundlegram/core/utils/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// A premium, "actively monitoring" offline state rather than a static
/// dead-end error page: a pulsing radar animation, a live connection
/// readout backed by [Connectivity], and an auto-retry countdown ring —
/// so the screen visibly does something rather than just apologizing.
///
/// [onOpenNetworkSettings] is optional. If your project adds a settings
/// deep-link package (e.g. `app_settings`), wire it here:
///   NoInternetWidget(onOpenNetworkSettings: () => AppSettings.openAppSettings(type: AppSettingsType.wifi))
/// Left null, the "Open network settings" link is simply hidden rather
/// than shipping a broken call.
class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({super.key, this.onOpenNetworkSettings});

  final VoidCallback? onOpenNetworkSettings;

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget>
    with SingleTickerProviderStateMixin {
  static const _retryInterval = Duration(seconds: 8);

  late final AnimationController _radarController;
  Timer? _countdownTimer;
  Duration _timeUntilRetry = _retryInterval;
  bool _isCheckingNow = false;

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _timeUntilRetry = _retryInterval;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _timeUntilRetry -= const Duration(seconds: 1);
      });
      if (_timeUntilRetry <= Duration.zero) {
        _checkConnection(isAuto: true);
      }
    });
  }

  Future<void> _checkConnection({bool isAuto = false}) async {
    if (_isCheckingNow) return;
    setState(() => _isCheckingNow = true);

    // A brief minimum duration so the "Checking…" state is perceptible
    // even on a near-instant result — otherwise a manual tap can feel
    // like it did nothing.
    final results = await Future.wait([
      Connectivity().checkConnectivity(),
      Future.delayed(const Duration(milliseconds: 550)),
    ]);
    final result = results.first as ConnectivityResult;

    if (!mounted) return;
    setState(() => _isCheckingNow = false);

    // If we're back online, the app's own connectivity listener (already
    // wired up at the App level) will remove this widget from the tree —
    // this screen doesn't need to navigate anywhere itself. We just reset
    // the countdown for the case where the check comes back still offline.
    if (result == ConnectivityResult.none) {
      _startCountdown();
    } else if (!isAuto) {
      _startCountdown();
    }
  }

  @override
  void dispose() {
    _radarController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countdownProgress =
        1 - (_timeUntilRetry.inMilliseconds / _retryInterval.inMilliseconds);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E12),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF10151B), Color(0xFF0B0E12)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _RadarIcon(controller: _radarController),
                const SizedBox(height: 36),
                const Text(
                  "You're offline",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Your transactions and balance are safe — we just need '
                  'a connection to sync them.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.55),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _StatusCard(
                  isChecking: _isCheckingNow,
                  countdownProgress: countdownProgress.clamp(0.0, 1.0),
                  secondsLeft: _timeUntilRetry.inSeconds.clamp(
                    0,
                    _retryInterval.inSeconds,
                  ),
                  onRetryNow: () => _checkConnection(),
                ),
                if (widget.onOpenNetworkSettings != null) ...[
                  const SizedBox(height: 18),
                  TextButton(
                    onPressed: widget.onOpenNetworkSettings,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                    ),
                    child: const Text(
                      'Open network settings',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Three concentric rings pulsing outward from a signal glyph — a "scanning"
/// motion rather than a static broken-connection illustration.
class _RadarIcon extends StatelessWidget {
  const _RadarIcon({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              for (final delay in [0.0, 0.33, 0.66])
                _PulseRing(progress: (controller.value + delay) % 1.0),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.12),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.4),
                    width: 1.2,
                  ),
                ),
                child: Icon(
                  Icons.signal_wifi_off_rounded,
                  size: 28,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PulseRing extends StatelessWidget {
  const _PulseRing({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final size = 64.0 + (progress * 76.0);
    final opacity = (1 - progress) * 0.35;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(opacity),
          width: 1.4,
        ),
      ),
    );
  }
}

/// Live status readout + auto-retry countdown, styled as a single
/// dark-glass card rather than a boxed paragraph of instructions.
class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.isChecking,
    required this.countdownProgress,
    required this.secondsLeft,
    required this.onRetryNow,
  });

  final bool isChecking;
  final double countdownProgress;
  final int secondsLeft;
  final VoidCallback onRetryNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecking
                      ? const Color(0xFFF5A623)
                      : const Color(0xFFEF4444),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                isChecking ? 'Checking connection…' : 'No connection detected',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  isChecking
                      ? 'Hold on a moment.'
                      : 'Retrying automatically in ${secondsLeft}s',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                width: 22,
                height: 22,
                child: isChecking
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      )
                    : CircularProgressIndicator(
                        strokeWidth: 2,
                        value: countdownProgress,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.primaryColor,
                        ),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isChecking ? null : onRetryNow,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.primaryColor.withOpacity(
                  0.4,
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(isChecking ? 'Checking…' : 'Check again'),
            ),
          ),
        ],
      ),
    );
  }
}