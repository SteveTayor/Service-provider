import 'package:bundlegram/core/config/env/base_env.dart';

class DevEnv implements BaseEnv{
  factory DevEnv() => _instance;
  DevEnv._internal();
  static final DevEnv _instance = DevEnv._internal();
  @override
  String get baseUrl => '';
  
}
