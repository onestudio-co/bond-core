import 'platforms/android/android_manager.dart';
import 'platforms/flutter/flutter_manager.dart';

abstract class SocialDriver {

  Future<void> handleAndroid(AndroidManager manager);

  Future<void> handleIOS();

  Future<void> handleFlutter(FlutterManager manager);
}
