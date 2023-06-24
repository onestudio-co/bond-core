import 'dart:io';

import 'AndroidManifest.dart';
import 'ManifestInterface.dart';
import 'ManifestNode.dart';
import 'package:xml/xml.dart';

class ManifestManager implements ManifestInterface {
  File manifestFile;
  late AndroidManifest _manifest;

  ManifestManager(this.manifestFile) {
    final document = XmlDocument.parse(manifestFile.readAsStringSync());
    XmlElement? applicationElement = document.getElement("manifest");
    if (applicationElement == null) {
      throw Exception("Invalid manifest file");
    }
    ManifestNode application = ManifestNode.parse(applicationElement);
    AndroidManifest model = AndroidManifest(application);
    _manifest = model;
  }

  @override
  Future<AndroidManifest> getManifest() async {
    // TODO: implement getManifest
    return _manifest;
  }

  @override
  Future<void> removeManifestNode(ManifestNode node) async {
    var manifest = await getManifest();
    manifest.remove(node);
    manifestFile.writeAsStringSync(manifest.toXml());
  }

  @override
  Future<void> addManifestNodeToParent(
      ManifestNode parent, ManifestNode node) async {
    var manifest = await getManifest();
    // parent.add(node);
    var result = manifest.filterBy(parent)[0];
    result.add(node);
    manifestFile.writeAsStringSync(manifest.toXml());
  }

  @override
  Future<void> addManifestNodeToRoot(ManifestNode node) async {
    var manifest = await getManifest();
    manifest.add(node);
    manifestFile.writeAsStringSync(manifest.toXml());
  }

  @override
  Future<void> updateManifestNode(ManifestNode node) async {
    var manifest = await getManifest();
    var result = manifest.filterBy(node);

    if (result.length == 1) {
      ManifestNode preNode = result[0];
      preNode.update(node);
      manifestFile.writeAsStringSync(manifest.toXml());
    }
  }

  @override
  Future<List<ManifestNode>> filterBy(String name, {String? parentName}) async {
    var manifest = await getManifest();
    return manifest.filterByName(name, parentName: parentName);
  }
}
