import 'package:xml/xml.dart';

import 'manifest_node.dart';

class AndroidManifest {
  final ManifestNode _root;

  AndroidManifest(this._root);

  @override
  String toString() {
    return 'AndroidManifest{applicaiton: $_root}';
  }

  String toXml() {
    XmlDocument xmlDocument = XmlDocument();
    xmlDocument.children.add(ManifestNode.toXml(_root));
    return xmlDocument.toXmlString(
        pretty: true,
        // indent: "  ",
        // newLine: "\n",
        indentAttribute: (e) => true);
  }

  void add(ManifestNode node) {
    _root.add(node);
  }

  List<ManifestNode> filterByName(String name, {String? parentName}) {
    return _root.filterByName(name, parentName: parentName);
  }

  List<ManifestNode> filterBy(ManifestNode node) {
    var lst = _root.filterBy(node);
    return lst;
  }

  void remove(ManifestNode node) {
    _root.remove(node);
  }

  // ManifestNode getRoot() {
  //   return _root;
  // }
}
