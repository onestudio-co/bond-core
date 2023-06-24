import 'dart:io';

import '../../config.dart';
import '../../platforms/flutter/flutter_manager.dart';
import '../../platforms/flutter/pubspec/dependency/flutter_dependency.dart';
import '../../social_provider.dart';
import '../../platforms/android/android_manager.dart';
import '../../platforms/android/library/android_library.dart';
import '../../platforms/android/plugin/android_plugin.dart';

class GoogleProvider implements SocialDriver {
  GoogleConfig config;

  GoogleProvider(this.config);

  @override
  Future<void> handleAndroid(AndroidManager manager) async {
    var googleServices =
        File("${Directory.current.path}/android/app/google-services.json");
    if (!googleServices.existsSync()) {
      throw Exception("missing file: /android/app/google-services.json");
    }

    await manager
        .addPlugin(AndroidPlugin("com.google.gms:google-services", "4.3.5"));
    await manager
        .applyPlugin(AndroidPlugin("com.google.gms.google-services", "4.3.5"));

    var analytics =
        AndroidLibrary("com.google.firebase:firebase-analytics", version: "+");
    await manager.addLibrary(analytics);
  }

  @override
  Future<void> handleIOS() async {}

  @override
  Future<void> handleFlutter(FlutterManager manager) async {
    await manager.listDependencies();
    await manager.addDependency(FlutterDependency("firebase_core", "^1.0.1"));
    await manager.addDependency(FlutterDependency("firebase_auth", "^1.0.1"));
    await manager.addDependency(FlutterDependency("google_sign_in", "^5.0.0"));
    await manager.pubGet();
  }
}
