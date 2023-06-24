import '../../../util/console.dart';
import '../../config.dart';
import '../../platforms/flutter/flutter_manager.dart';
import '../../platforms/flutter/pubspec/dependency/flutter_dependency.dart';
import '../../social_provider.dart';
import '../../platforms/android/android_manager.dart';
import '../../platforms/android/library/android_library.dart';
import '../../platforms/android/manifest/manifest_node.dart';
import '../../platforms/android/plugin/android_plugin.dart';

class GoogleProvider implements SocialDriver {
  GoogleConfig config;

  GoogleProvider(this.config);

  @override
  Future<void> handleAndroid(AndroidManager manager) async {
    // await manager.addLibrary(AndroidLibrary("com.kradwan:dsadsa", "1.23"));

    var plugins = await manager.listPlugins();
    for (var element in plugins) {
      printWarning(
          "Plugin: ${element.name.padRight(32, ' ')}  version: ${element.version}");
    }

    print("\n\n");

    var libs = await manager.listLibraries();
    for (var element in libs) {
      printWarning(
          "Library: ${element.name.padRight(32, ' ')}  version: ${element.version}");
    }
    // await manager
    //     .addPlugin(AndroidPlugin("com.google.gms:google-services", "4.3.15"));
    // await manager.addPlugin(AndroidPlugin(
    //     "com.google.firebase:firebase-crashlytics-gradle", "2.8.1"));

    // await manager.removePlugin(AndroidPlugin("org.jetbrains.kotlin:kotlin-gradle-plugin", "1.6.10"));

    manager.addManifestNodeToRoot(ManifestNode("kareem", [], []));
    var applications =
        (await manager.filterBy("application", parentName: "manifest"));

    if (applications.isNotEmpty) {
      await manager.addManifestNodeToParent(
          applications[0], ManifestNode("kareem2", [], []));
    }

    var activities =
        (await manager.filterBy("activity", parentName: "application2"));

    if (activities.isNotEmpty) {
      await manager.addManifestNodeToParent(
          activities[0], ManifestNode("kareem3", [], []));
    }

  }

  @override
  Future<void> handleIOS() async {}

  @override
  Future<void> handleFlutter(FlutterManager manager) async {
    await manager.listDependencies();
    await manager.addDependency(FlutterDependency("kareem", "1.2.3"));
    await manager.remove(FlutterDependency("meta", "^1.8.2"));
  }
}
