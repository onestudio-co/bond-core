import 'platforms/android/android_manager.dart';

abstract class SocialDriver {

  Future<void> handleAndroid(AndroidManager manager);

  Future<void> handleIOS();
}
