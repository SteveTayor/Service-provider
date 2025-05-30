

import 'package:bundlegram/core/utils/enums.dart';

class UserState{
  UserState({
    required this.submitUsername,
     
    required this.userName,
  });
  factory UserState.initial(){
    return UserState(
       
      submitUsername: false,
     userName: '',  );

  
  }
  final String userName;

  final bool submitUsername;
  UserState copyWith({
    String?userName,
    LoadState? loadState,
    bool?submitUsername,
  }){
    return UserState(
      submitUsername: submitUsername?? this.submitUsername,
     userName: userName?? this.userName,);
  }
}
