
import 'package:bundlegram/bootstrap.dart';
import 'package:bundlegram/core/config/env/base_env.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
   F.appFlavor = Flavor.dev;
  bootstrap(() => const ProviderScope(child: App()));
}
