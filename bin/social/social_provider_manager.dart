import 'dart:io';

import 'platforms/flutter/flutter_manager.dart';
import 'social_provider.dart';
import 'platforms/android/android_manager.dart';

class SocialDriverManager {
  final List<SocialDriver> _drivers = [];

  void addPlatform(SocialDriver driver) {
    _drivers.add(driver);
  }

  Future<void> start() async {
    AndroidManager androidManager =
        AndroidManager(Directory("${Directory.current.path}/android"));
    FlutterManager flutterManager =
        FlutterManager("${Directory.current.path}/pubspec.yaml");

    for (var element in _drivers) {
      await element.handleAndroid(androidManager);
      await element.handleIOS();
      await element.handleFlutter(flutterManager);
    }
  }
}
