import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

class ProviderLogger extends ProviderObserver {
  final _logger = Logger('ProviderLogger');

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    _logger.fine(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "oldValue": "$previousValue",
  "newValue": "$newValue"
}''',
    );
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    _logger.fine(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "value": "$value"
}''',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    _logger.fine(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "action": "disposed"
}''',
    );
  }
} 