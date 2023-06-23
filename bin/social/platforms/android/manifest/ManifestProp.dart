import 'package:xml/xml.dart';

class ManifestProp {
  final String key;
  String value;

  ManifestProp(this.key, this.value);

  static ManifestProp parse(XmlAttribute attr) {
    ManifestProp prop = ManifestProp(attr.qualifiedName, attr.value);
    return prop;
  }

  static XmlAttribute toXml(ManifestProp prop) {
    return XmlAttribute(XmlName(prop.key), prop.value);
  }

  @override
  String toString() {
    return 'ManifestProp{key: $key, value: $value}';
  }
}
