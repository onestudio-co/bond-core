import 'dart:io';

import 'library/AndroidLibrary.dart';
import 'library/AndroidLibraryInterface.dart';
import 'library/AndroidLibraryManager.dart';
import 'manifest/AndroidManifest.dart';
import 'manifest/ManifestInterface.dart';
import 'manifest/ManifestManager.dart';
import 'plugin/AndroidPlugin.dart';
import 'manifest/ManifestNode.dart';
import 'plugin/AndroidPluginInterface.dart';
import 'plugin/AndroidPluginManager.dart';

class AndroidManager
    implements
        AndroidPluginInterface,
        AndroidLibraryInterface,
        ManifestInterface {
  Directory _android;

  late AndroidPluginManager _pluginManager;
  late AndroidLibraryManager _libraryManager;
  late ManifestManager _manifestManager;

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
  Future<void> addManifestNode(ManifestNode node) async {
    return await _manifestManager.addManifestNode(node);
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
  Future<void> setManifestNode(ManifestNode node) async {
    return await _manifestManager.setManifestNode(node);
  }
}
