import 'package:bundlegram/presentation/features/onboarding/notifier/onboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends AutoDisposeNotifier<OnboardingState> {
  @override
  OnboardingState build() {
    return OnboardingState.initial();
  }

  void updateWalkThroughIndex(int index) {
    state = state.copyWith(walkThroughIndex: index);
  }
}

final onboardingNotifierProvider =
    NotifierProvider.autoDispose<OnboardingNotifier, OnboardingState>(
  OnboardingNotifier.new,
);
