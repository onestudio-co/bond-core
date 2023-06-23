import 'platforms/android/AndroidManager.dart';

abstract class SocialDriver {

  Future<void> handleAndroid(AndroidManager manager);

  Future<void> handleIOS();
}
