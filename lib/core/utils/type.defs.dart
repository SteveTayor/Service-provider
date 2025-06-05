import 'package:bundlegram/core/utils/enums.dart';
import 'package:flutter/material.dart';

typedef MessageText = ({String message, MessageType messageType});
typedef ItemBuilder<T> = Widget Function(BuildContext, T, int);
typedef OnSearchChanged = void Function(String);
typedef OnFilterPressed = void Function(BuildContext);
