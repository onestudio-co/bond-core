import 'dart:io';

import '../util/console.dart';
import 'social_provider.dart';
import 'package:dependency_manipulator/platforms/android/android.dart';
import 'package:dependency_manipulator/platforms/flutter/flutter.dart';

class SocialManager {
  final List<SocialDriver> _drivers = [];

  final AndroidManager _androidManager =
      AndroidManager(Directory("${Directory.current.path}/android"));
  final FlutterManager _flutterManager =
      FlutterManager(File("${Directory.current.path}/pubspec.yaml"));

  void addPlatform(SocialDriver driver) {
    _drivers.add(driver);
  }

  Future<void> start() async {
    for (var element in _drivers) {
      printBlue("Bond Socialite starting ...");
      await element.handleFlutter(_flutterManager);

      await _androidManager.prepareEnv();

      await element.handleAndroid(_androidManager);
      var status = await _androidManager.build();
      if (!status) {
        throw Exception("Exit");
      }

      await element.handleIOS();
    }

    printSuccess("Bond Socialite finish successfully");
  }

  Future<void> rollback() async {
    await _flutterManager.pubGet();
  }
}
