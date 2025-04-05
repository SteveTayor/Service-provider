

import 'package:bundlegram/core/utils/enums.dart';

class UserState{
  UserState({
    required this.submitUsername,
    required this.loadState,
    required this.userName,
  });
  factory UserState.initial(){
    return UserState(
       
      submitUsername: false,
     userName: '', loadState: LoadState.loading,);

  
  }
  final String userName;
  final LoadState loadState;
  final bool submitUsername;
  UserState copyWith({
    String?userName,
    LoadState? loadState,
    bool?submitUsername,
  }){
    return UserState(
      loadState: loadState ?? this.loadState,
      submitUsername: submitUsername?? this.submitUsername,
     userName: userName?? this.userName,);
  }
}
