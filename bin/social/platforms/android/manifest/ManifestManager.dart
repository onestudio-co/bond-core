import 'dart:io';

import 'AndroidManifest.dart';
import 'ManifestInterface.dart';
import 'ManifestNode.dart';

class ManifestManager implements ManifestInterface {
  File manifestFile;

  ManifestManager(this.manifestFile);

  @override
  Future<void> addManifestNode(ManifestNode node) {
    // TODO: implement addManifestNode
    throw UnimplementedError();
  }

  @override
  Future<AndroidManifest> getManifest() {
    // TODO: implement getManifest
    throw UnimplementedError();
  }

  @override
  Future<void> removeManifestNode(ManifestNode node) {
    // TODO: implement removeManifestNode
    throw UnimplementedError();
  }

  @override
  Future<void> setManifestNode(ManifestNode node) {
    // TODO: implement setManifestNode
    throw UnimplementedError();
  }
}
