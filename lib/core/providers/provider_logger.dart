import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

base class ProviderLogger extends ProviderObserver {
  final _logger = Logger('ProviderLogger');

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    final provider = context.provider;

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
    ProviderObserverContext context,
    Object? value,
  ) {
    final provider = context.provider;

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
    ProviderObserverContext context,
  ) {
    final provider = context.provider;

    _logger.fine(
      '''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "action": "disposed"
}''',
    );
  }
}
