// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:logging/logging.dart';

// abstract class BaseStateNotifier<T> extends StateNotifier<T> {
//   BaseStateNotifier(super.state) {
//     _logger = Logger(runtimeType.toString());
//   }

//   late final Logger _logger;

//   /// Safely updates state with error handling and logging
//   Future<void> safeUpdate(Future<T> Function() update) async {
//     try {
//       final newState = await update();
//       state = newState;
//     } catch (error, stackTrace) {
//       _logger.severe('Error updating state', error, stackTrace);
//       rethrow;
//     }
//   }

//   /// Logs state changes for debugging
//   @protected
//   void logStateChange(String action, {Map<String, dynamic>? details}) {
//     _logger.fine({
//       'action': action,
//       'details': details,
//       'state': state.toString(),
//     });
//   }

//   @override
//   void dispose() {
//     _logger.fine('Disposing $runtimeType');
//     super.dispose();
//   }
// }
