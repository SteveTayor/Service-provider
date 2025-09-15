import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';

final notificationSettingsProvider =
    ChangeNotifierProvider((ref) => NotificationSettingsNotifier(ref));

class NotificationSettingsNotifier extends ChangeNotifier {
  final Ref ref;
  NotificationSettingsNotifier(this.ref) {
    _loadSettings();
  }

  bool transactionAlerts = true;
  bool accountActivities = true;
  bool promotions = true;
  bool serviceUpdates = true;

  Future<void> _loadSettings() async {
    final storage = ref.read(secureStorageHelperProvider);
    transactionAlerts = await storage.getBool('transactionAlerts') ?? true;
    accountActivities = await storage.getBool('accountActivities') ?? true;
    promotions = await storage.getBool('promotions') ?? true;
    serviceUpdates = await storage.getBool('serviceUpdates') ?? true;
    notifyListeners();
  }

  Future<void> toggleTransactionAlerts(bool value) async {
    transactionAlerts = value;
    final storage = ref.read(secureStorageHelperProvider);
    await storage.saveBool('transactionAlerts', value);
    notifyListeners();
  }

  Future<void> toggleAccountActivities(bool value) async {
    accountActivities = value;
    final storage = ref.read(secureStorageHelperProvider);
    await storage.saveBool('accountActivities', value);
    notifyListeners();
  }

  Future<void> togglePromotions(bool value) async {
    promotions = value;
    final storage = ref.read(secureStorageHelperProvider);
    await storage.saveBool('promotions', value);
    notifyListeners();
  }

  Future<void> toggleServiceUpdates(bool value) async {
    serviceUpdates = value;
    final storage = ref.read(secureStorageHelperProvider);
    await storage.saveBool('serviceUpdates', value);
    notifyListeners();
  }
}
