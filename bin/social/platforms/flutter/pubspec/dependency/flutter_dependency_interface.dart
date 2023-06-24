import 'flutter_dependency.dart';

abstract class FlutterDependencyInterface {
  Future<List<FlutterDependency>> listDependencies(
      {String? name, String? version});

  Future<void> addDependency(FlutterDependency dependency);

  Future<void> update(FlutterDependency dependency);

  Future<void> remove(FlutterDependency dependency);

  Future<void> pubGet();
}
