import 'AndroidManifest.dart';
import 'ManifestNode.dart';

abstract class ManifestInterface {
  Future<AndroidManifest> getManifest();

  Future<void> addManifestNode(ManifestNode node);

  Future<void> setManifestNode(ManifestNode node);

  Future<void> removeManifestNode(ManifestNode node);
}
