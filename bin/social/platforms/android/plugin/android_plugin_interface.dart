import 'android_plugin.dart';

abstract class AndroidPluginInterface {
  Future<List<AndroidPlugin>> listPlugins();

  Future<AndroidPlugin> getPlugin(String name, String version);

  Future<List<AndroidPlugin>> getPlugins(String name);

  Future<void> updatePlugin(AndroidPlugin plugin);

  Future<void> removePlugin(AndroidPlugin plugin);

  Future<void> addPlugin(AndroidPlugin plugin);
}
