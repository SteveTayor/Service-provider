import 'package:bundlegram/bootstrap.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await bootstrap(
    () => ProviderScope(
      // child: App(),
      child: DevicePreview(
        enabled: false, // set to false in production
        builder: (context) => const App(),
      ),
    ),
  );
}
