import 'package:dependency_manipulator/platforms/android/android.dart';
import 'package:dependency_manipulator/platforms/flutter/flutter.dart';

import '../../config.dart';
import '../../social_provider.dart';

class AppleProvider implements SocialDriver {
  AppleConfig config;

  AppleProvider(this.config);

  @override
  Future<void> handleAndroid(AndroidManager manager) {
    // TODO: implement handleAndroid
    throw UnimplementedError();
  }

  @override
  Future<void> handleIOS() {
    // TODO: implement handleIOS
    throw UnimplementedError();
  }

  @override
  Future<void> handleFlutter(FlutterManager manager) {
    // TODO: implement handleFlutter
    throw UnimplementedError();
  }
}
