import 'package:flutter/material.dart';

/// Global key for showing snackbars from non-UI code (providers, services).
/// Keep this file minimal to avoid circular imports.
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
