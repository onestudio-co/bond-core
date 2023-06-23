import 'dart:io';

import '../../../../transaction/transaction_manager.dart';
import '../../../../util/console.dart';
import '../../../../util/file.dart';
import 'AndroidPlugin.dart';
import 'AndroidPluginInterface.dart';

class AndroidPluginManager implements AndroidPluginInterface {
  File buildFile;
  final Map<int, AndroidPlugin> _cache = {};

  AndroidPluginManager(this.buildFile);

  @override
  Future<void> addPlugin(AndroidPlugin plugin) async {
    List<SearchResult> result = [];
    result = await buildFile.search("dependencies");
    if (result.isEmpty) {
      throw Exception("No dependencies tag into /android/build.gradle");
    }

    Map<int, String> linesIndex = await buildFile.linesIndexed();

    var content = "";
    linesIndex.forEach((key, value) {
      if (key == result[0].index + 1) {
        content += "        classpath '${plugin.name}:${plugin.version}'\n";
      }
      content += "$value\n";
    });

    buildFile.writeAsStringSync(content);
  }

  @override
  Future<AndroidPlugin> getPlugin(String name, String version) {
    // TODO: implement getPlugin
    throw UnimplementedError();
  }

  @override
  Future<List<AndroidPlugin>> getPlugins(String name) {
    // TODO: implement getPlugins
    throw UnimplementedError();
  }

  @override
  Future<List<AndroidPlugin>> listPlugins() async {
    // TODO: implement listPlugins

    var result = await buildFile.search("classpath");

    if (result.isEmpty) {
      return [];
    }
    List<AndroidPlugin> plugins = [];
    for (var element in result) {
      var rawPlugin = element.line
          .trim()
          .replaceAll("classpath ", "")
          .replaceAll("'", "")
          .replaceAll('"', '');

      if (rawPlugin != '') {
        var parts = rawPlugin.split(":");
        var pluginVersion = parts.removeLast();
        var pluginName = parts.join(":");

        if (pluginVersion.startsWith("\$")) {
          var isVar = pluginVersion.startsWith("\$");
          if (isVar) {
            var resolveVersionResult = await buildFile
                .search("ext.${pluginVersion.replaceAll("\$", "")}");
            if (resolveVersionResult.isNotEmpty) {
              var version = resolveVersionResult[0]
                  .line
                  .replaceAll(
                      "ext.${pluginVersion.replaceAll("\$", "")} = ", "")
                  .replaceAll("'", "")
                  .replaceAll('"', '');
              pluginVersion = version;
            }
          }
        }

        var plugin = AndroidPlugin(pluginName, pluginVersion.trim());
        plugins.add(plugin);
        _cache[element.index] = plugin;
      }
    }

    return plugins;
  }

  @override
  Future<void> removePlugin(AndroidPlugin plugin) async {
    List<SearchResult> result = [];
    result = await buildFile.search("dependencies");
    if (result.isEmpty) {
      throw Exception("No dependencies tag into /android/build.gradle");
    }
    await listPlugins();
    var pluginIndex = -1;
    for (var element in _cache.entries) {
      if (element.value.name == plugin.name &&
          element.value.version.trim() == plugin.version.trim()) {
        pluginIndex = element.key;
        break;
      }
    }

    if (pluginIndex == -1) {
      printWarning("No Android Plugin Matched ");
      return;
    }

    Map<int, String> linesIndex = await buildFile.linesIndexed();

    String content = "";
    linesIndex.forEach((key, value) {
      if (key != pluginIndex) {
        content += "$value\n";
      }
    });

    buildFile.writeAsStringSync(content);
  }

  @override
  Future<void> updatePlugin(AndroidPlugin plugin) async {
    List<SearchResult> result = [];
    result = await buildFile.search("dependencies");
    if (result.isEmpty) {
      throw Exception("No dependencies tag into /android/build.gradle");
    }
    await listPlugins();

    var pluginIndex = -1;
    for (var element in _cache.entries) {
      if (element.value.name == plugin.name &&
          element.value.version.trim() == plugin.version.trim()) {
        pluginIndex = element.key;
        break;
      }
    }

    if (pluginIndex == -1) {
      printWarning("No Android Plugin Matched ");
      return;
    }

    Map<int, String> linesIndex = await buildFile.linesIndexed();

    String content = "";
    linesIndex.forEach((key, value) {
      if (key != pluginIndex) {
        content += "        classpath '${plugin.name}:${plugin.version}'\n";
      }
    });

    buildFile.writeAsStringSync(content);
  }
}
