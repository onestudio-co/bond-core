import 'package:dependency_manipulator/platforms/android/android.dart';
import 'package:dependency_manipulator/platforms/flutter/flutter.dart';

abstract class SocialDriver {
  Future<void> handleAndroid(AndroidManager manager);

  Future<void> handleIOS();

  Future<void> handleFlutter(FlutterManager manager);
}
