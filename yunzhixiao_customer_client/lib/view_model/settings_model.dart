import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yunzhixiao_customer_client/commons/constants/config.dart';
import 'package:yunzhixiao_customer_client/commons/managers/storage_manager.dart';
import 'package:yunzhixiao_customer_client/models/settings.dart';
import 'package:yunzhixiao_customer_client/models/user.dart';
import 'package:yunzhixiao_customer_client/service/user_repository.dart';

class SettingsModel extends ChangeNotifier {
  static const String settingsKey = Config.SETTINGS_KEY;

  Settings _settings;

  Settings get settings => _settings;

  bool get hasSettings => settings != null;

  SettingsModel() {
    var settingsMap = StorageManager.localStorage.getItem(settingsKey);
    _settings = settingsMap != null ? Settings.fromJson(settingsMap) : Settings.fromJson({
      "order_settings": {"auto_order": true, "sms_notification": true},
      "notification_settings": {
        "latest_order_notification": true,
        "auto_volume_max": true,
        "vibrate_notification": true,
        "ring_type": 0,
        "notification_freq": 0
      }
    });
  }

  saveSettings(Settings settings) {
    _settings = settings;
    notifyListeners();
    StorageManager.localStorage.setItem(settingsKey, settings);
  }

  clearSettings() {
    _settings = null;
    notifyListeners();
    StorageManager.localStorage.deleteItem(settingsKey);
  }

  saveOrderSettings({bool autoOrder, bool smsNotification}) {
    _settings.orderSettings = OrderSettings.fromJson({
      "auto_order":
          autoOrder == null ? _settings.orderSettings.autoOrder : autoOrder,
      "sms_notification": smsNotification == null
          ? _settings.orderSettings.smsNotification
          : smsNotification
    });
    notifyListeners();
    StorageManager.localStorage.setItem(settingsKey, settings);
  }

  saveNotificationSettings(
      {bool latestOrderNotification,
      bool autoVolumeMax,
      bool vibrateNotification,
      int ringType,
      int notificationFreq}) {
    _settings.notificationSettings = NotificationSettings.fromJson({
      "latest_order_notification": latestOrderNotification == null
          ? _settings.notificationSettings.latestOrderNotification
          : latestOrderNotification,
      "auto_volume_max": autoVolumeMax == null
          ? _settings.notificationSettings.autoVolumeMax
          : autoVolumeMax,
      "vibrate_notification": vibrateNotification == null
          ? _settings.notificationSettings.vibrateNotification
          : vibrateNotification,
      "ring_type":
          ringType == null ? _settings.notificationSettings.ringType : ringType,
      "notification_freq": notificationFreq == null
          ? _settings.notificationSettings.notificationFreq
          : notificationFreq
    });
    notifyListeners();
    StorageManager.localStorage.setItem(settingsKey, settings);
  }
}
