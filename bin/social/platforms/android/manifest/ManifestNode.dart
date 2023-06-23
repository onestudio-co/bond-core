import 'package:xml/xml.dart';

import 'ManifestProp.dart';

class ManifestNode {
  final String uuid = "${DateTime.now().microsecondsSinceEpoch}";
  final String title;
  List<ManifestNode> _childs;
  List<ManifestProp> _props;

  ManifestNode? _parent = null;

  ManifestNode(this.title, this._childs, this._props);

  static ManifestNode parse(XmlElement element) {
    List<ManifestNode> childs = [];
    List<ManifestProp> props = [];

    var node = ManifestNode(element.qualifiedName, childs, props);
    for (var element in element.childElements) {
      ManifestNode child = ManifestNode.parse(element);
      child._parent = node;
      childs.add(child);
    }

    for (var element in element.attributes) {
      ManifestProp prop = ManifestProp.parse(element);
      props.add(prop);
    }

    return node;
  }

  void add(ManifestNode node) {
    _childs.add(node);
  }

  List<ManifestNode> filterBy(ManifestNode node) {
    var lst = _childs.where((element) => element.uuid == node.uuid).toList();
    for (var item in _childs) {
      lst.addAll(item.filterBy(node));
    }
    return lst;
  }

  List<ManifestNode> filterByName(String name, {String? parentName}) {
    var lst = _childs
        .where((element) => element.title == name)
        .toList();
    for (var item in _childs) {
      lst.addAll(item.filterByName(name, parentName: parentName));
    }
    return lst;
  }

  void remove(ManifestNode remove) {
    _childs.removeWhere((element) => element.uuid == remove.uuid);
    for (var element in _childs) {
      element.remove(element);
    }
  }

  static XmlElement toXml(ManifestNode node) {
    List<XmlAttribute> attrs =
        node._props.map((e) => ManifestProp.toXml(e)).toList();
    List<XmlElement> childs =
        node._childs.map((e) => ManifestNode.toXml(e)).toList();

    XmlElement element = XmlElement(XmlName(node.title), attrs, childs);
    return element;
  }

  void update(ManifestNode node) {
    _childs = node._childs;
    _props = node._props;
  }

  @override
  String toString() {
    return 'ManifestNode{title: $title, childs: $_childs, props: $_props}';
  }
}
