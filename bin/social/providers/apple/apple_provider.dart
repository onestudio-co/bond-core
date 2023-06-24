import '../../config.dart';
import '../../social_provider.dart';
import '../../platforms/android/android_manager.dart';

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
}
