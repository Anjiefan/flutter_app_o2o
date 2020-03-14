class Settings {
  OrderSettings orderSettings;
  NotificationSettings notificationSettings;

  Settings({this.orderSettings, this.notificationSettings});

  Settings.fromJson(Map<String, dynamic> json) {
    orderSettings = json['order_settings'] != null
        ? new OrderSettings.fromJson(json['order_settings'])
        : null;
    notificationSettings = json['notification_settings'] != null
        ? new NotificationSettings.fromJson(json['notification_settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderSettings != null) {
      data['order_settings'] = this.orderSettings.toJson();
    }
    if (this.notificationSettings != null) {
      data['notification_settings'] = this.notificationSettings.toJson();
    }
    return data;
  }
}

class OrderSettings {
  bool autoOrder;
  bool smsNotification;

  OrderSettings({this.autoOrder, this.smsNotification});

  OrderSettings.fromJson(Map<String, dynamic> json) {
    autoOrder = json['auto_order'];
    smsNotification = json['sms_notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auto_order'] = this.autoOrder;
    data['sms_notification'] = this.smsNotification;
    return data;
  }
}

class NotificationSettings {
  bool latestOrderNotification;
  bool autoVolumeMax;
  bool vibrateNotification;
  int ringType;
  int notificationFreq;

  NotificationSettings(
      {this.latestOrderNotification,
        this.autoVolumeMax,
        this.vibrateNotification,
        this.ringType,
        this.notificationFreq});

  NotificationSettings.fromJson(Map<String, dynamic> json) {
    latestOrderNotification = json['latest_order_notification'];
    autoVolumeMax = json['auto_volume_max'];
    vibrateNotification = json['vibrate_notification'];
    ringType = json['ring_type'];
    notificationFreq = json['notification_freq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latest_order_notification'] = this.latestOrderNotification;
    data['auto_volume_max'] = this.autoVolumeMax;
    data['vibrate_notification'] = this.vibrateNotification;
    data['ring_type'] = this.ringType;
    data['notification_freq'] = this.notificationFreq;
    return data;
  }
}
