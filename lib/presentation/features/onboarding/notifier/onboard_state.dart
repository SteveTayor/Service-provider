

 
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/presentation/features/onboarding/notifier/user_state.dart';

class OnboardingState extends UserState{
  OnboardingState({
 
    required this.walkThroughIndex,
 
  }) : super(submitUsername: false, 
  loadState: LoadState.loading, userName: '',);
  factory OnboardingState.initial(){
    return OnboardingState(
      walkThroughIndex:0,
    );

  
  }
 
  final int walkThroughIndex;
 
  @override
  OnboardingState copyWith({
    int? walkThroughIndex,
    String?userName,
    LoadState? loadState,
    bool?submitUsername,
  }){
    return OnboardingState(
    
      walkThroughIndex: walkThroughIndex?? this.walkThroughIndex,);
  }
}
