import 'AndroidManifest.dart';
import 'ManifestNode.dart';

abstract class ManifestInterface {
  Future<AndroidManifest> getManifest();

  Future<void> addManifestNodeToRoot(ManifestNode node);

  Future<void> addManifestNodeToParent(ManifestNode parent, ManifestNode node);

  Future<void> updateManifestNode(ManifestNode node);

  Future<void> removeManifestNode(ManifestNode node);

  Future<List<ManifestNode>> filterBy(String name, {String? parentName});
}
