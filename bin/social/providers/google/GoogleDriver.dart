import '../../SocialDriver.dart';
import '../../platforms/android/AndroidManager.dart';
import '../../platforms/android/plugin/AndroidPlugin.dart';

class GoogleDriver implements SocialDriver {
  @override
  Future<void> handleAndroid(AndroidManager manager) async {
    var plugins = await manager.listPlugins();
    for (var element in plugins) {
      print(
          "Plugin: ${element.name.padRight(32, ' ')}  version: ${element.version}");
    }

    await manager.addPlugin(AndroidPlugin("com.google.gms:google-services", "4.3.15"));
    await manager.addPlugin(AndroidPlugin("com.google.firebase:firebase-crashlytics-gradle", "2.8.1"));
  }

  @override
  Future<void> handleIOS() async {}
}
