import 'package:bundlegram/bootstrap.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
