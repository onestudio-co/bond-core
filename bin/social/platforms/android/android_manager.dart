import 'dart:io';

import 'build/android_build_manager.dart';
import 'library/android_library.dart';
import 'library/android_library_interface.dart';
import 'library/android_library_manager.dart';
import 'manifest/android_manifest.dart';
import 'manifest/manifest_interface.dart';
import 'manifest/manifest_manager.dart';
import 'plugin/android_plugin.dart';
import 'manifest/manifest_node.dart';
import 'plugin/android_plugin_interface.dart';
import 'plugin/android_plugin_manager.dart';

class AndroidManager
    implements
        AndroidPluginInterface,
        AndroidLibraryInterface,
        ManifestInterface,
        AndroidBuildManager {
  Directory _android;

  late AndroidPluginManager _pluginManager;
  late AndroidLibraryManager _libraryManager;
  late ManifestManager _manifestManager;
  late AndroidBuildManager _buildManager;

  AndroidManager(this._android) {
    var pluginBuildFile = File("${_android.path}/build.gradle");
    if (!pluginBuildFile.existsSync()) {
      throw ArgumentError("file build.gradle is missing inside android folder");
    }
    _pluginManager = AndroidPluginManager(pluginBuildFile);

    var libraryBuildFile = File("${_android.path}/app/build.gradle");
    if (!libraryBuildFile.existsSync()) {
      throw ArgumentError(
          "file build.gradle is missing inside android/app/ folder");
    }
    _libraryManager = AndroidLibraryManager(libraryBuildFile);

    var manifestFile =
        File("${_android.path}/app/src/main/AndroidManifest.xml");
    if (!manifestFile.existsSync()) {
      throw ArgumentError(
          "file AndroidManifest.xml is missing inside /app/src/main/ folder");
    }
    _manifestManager = ManifestManager(manifestFile);

    _buildManager = AndroidBuildManager();
  }

  @override
  Future<void> addPlugin(AndroidPlugin plugin) async {
    return await _pluginManager.addPlugin(plugin);
  }

  @override
  Future<AndroidPlugin> getPlugin(String name, String version) async {
    return await _pluginManager.getPlugin(name, version);
  }

  @override
  Future<List<AndroidPlugin>> getPlugins(String name) async {
    return await _pluginManager.getPlugins(name);
  }

  @override
  Future<List<AndroidPlugin>> listPlugins() async {
    return await _pluginManager.listPlugins();
  }

  @override
  Future<void> removePlugin(AndroidPlugin plugin) async {
    return await _pluginManager.removePlugin(plugin);
  }

  @override
  Future<void> updatePlugin(AndroidPlugin plugin) async {
    return await _pluginManager.updatePlugin(plugin);
  }

  @override
  Future<List<AndroidLibrary>> listLibraries() async {
    return await _libraryManager.listLibraries();
  }

  @override
  Future<AndroidLibrary> getLibrary(String name, String version) async {
    return await _libraryManager.getLibrary(name, version);
  }

  @override
  Future<List<AndroidLibrary>> getLibraries(String name) async {
    return await _libraryManager.getLibraries(name);
  }

  @override
  Future<void> updateLibrary(AndroidLibrary library) async {
    return await _libraryManager.updateLibrary(library);
  }

  @override
  Future<void> removeLibrary(AndroidLibrary library) async {
    return await _libraryManager.removeLibrary(library);
  }

  @override
  Future<void> addLibrary(AndroidLibrary library) async {
    return await _libraryManager.addLibrary(library);
  }

  @override
  Future<AndroidManifest> getManifest() async {
    return await _manifestManager.getManifest();
  }

  @override
  Future<void> removeManifestNode(ManifestNode node) async {
    return await _manifestManager.removeManifestNode(node);
  }

  @override
  Future<void> addManifestNodeToParent(
      ManifestNode parent, ManifestNode node) async {
    return await _manifestManager.addManifestNodeToParent(parent, node);
  }

  @override
  Future<void> addManifestNodeToRoot(ManifestNode node) async {
    return await _manifestManager.addManifestNodeToRoot(node);
  }

  @override
  Future<void> updateManifestNode(ManifestNode node) async {
    return await _manifestManager.updateManifestNode(node);
  }

  @override
  Future<List<ManifestNode>> filterBy(String name, {String? parentName}) async {
    return await _manifestManager.filterBy(name, parentName: parentName);
  }

  @override
  Future<void> applyPlugin(AndroidPlugin plugin) async {
    return await _libraryManager.applyPlugin(plugin);
  }

  @override
  Future<bool> build() async {
    return await _buildManager.build();
  }

  @override
  Future<void> prepareEnv() async {
    return await _buildManager.prepareEnv();
  }
}
