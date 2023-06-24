import 'dart:io';

import 'social_provider.dart';
import 'platforms/android/android_manager.dart';

class SocialDriverManager {
  final List<SocialDriver> _drivers = [];

  void addPlatform(SocialDriver driver) {
    _drivers.add(driver);
  }

  Future<void> start() async {
    AndroidManager manager =
        AndroidManager(Directory("${Directory.current.path}/android"));

    for (var element in _drivers) {
      await element.handleAndroid(manager);
      await element.handleIOS();
    }
  }
}
