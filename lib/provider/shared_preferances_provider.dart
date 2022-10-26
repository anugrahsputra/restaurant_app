import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  SharedPreferencesProvider() {
    notificationSwitchCondition();
  }

  bool notificationSwitch = false;
  static const String notificationSwitchKey = 'notification_switch';

  void notificationSwitchCondition() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    notificationSwitch = preferences.getBool(notificationSwitchKey) ?? false;
    notifyListeners();
  }

  void changeNotificationSwitchCondition(value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(notificationSwitchKey, value);
    notificationSwitchCondition();
  }
}
