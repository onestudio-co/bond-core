import 'dart:io';

import 'flutter_dependency.dart';
import 'flutter_dependency_interface.dart';
import 'package:yaml_edit/yaml_edit.dart';
import 'package:yaml/yaml.dart';

class FlutterDependencyManager implements FlutterDependencyInterface {
  final File _pubspecFile;
  late YamlEditor _editor;

  FlutterDependencyManager(this._pubspecFile) {
    _editor = YamlEditor(_pubspecFile.readAsStringSync());
  }

  @override
  Future<void> addDependency(FlutterDependency dependency) async {
    var currentDependencies = await listDependencies(name: dependency.name);

    if (currentDependencies.isNotEmpty) {
      return;
    }

    var immutableDependencies = _editor.parseAt(["dependencies"]);
    var dependencies = Map.from(immutableDependencies.value);
    dependencies[dependency.name] = dependency.version;
    _editor.update(["dependencies"], dependencies);
    await _flush();
  }

  @override
  Future<List<FlutterDependency>> listDependencies(
      {String? name, String? version}) async {
    List<FlutterDependency> lst = [];

    YamlMap dependencies = _editor.parseAt(["dependencies"]).value;

    for (var element in dependencies.entries) {
      String name = element.key;
      if (name.toLowerCase() == 'flutter') {
        continue;
      }
      var version = element.value;

      if (version.runtimeType.toString() == "YamlMap") {
        version = "custom";
      }

      lst.add(FlutterDependency(name, version));
    }

    return lst
        .where((element) =>
            (name == null || (name == element.name)) &&
            (version == null || version == element.version))
        .toList();
  }

  @override
  Future<void> remove(FlutterDependency dependency) async {
    // TODO: implement remove

    try {
      var currentVersion = _editor.parseAt(["dependencies", dependency.name]);
      if (currentVersion.toString() == dependency.version) {
        var removed = _editor.remove(['dependencies', dependency.name]);
        await _flush();
      }
    } catch (error) {}
  }

  @override
  Future<void> update(FlutterDependency dependency) async {
    await remove(dependency);
    await addDependency(dependency);

    await _flush();
  }

  Future<void> _flush() async {
    _pubspecFile.writeAsStringSync(_editor.toString());
  }

  @override
  Future<void> pubGet() async {
    await Process.run("flutter", ["pub", "get"]);
  }
}
