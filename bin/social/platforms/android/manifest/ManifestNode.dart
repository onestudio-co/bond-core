import 'ManifestProp.dart';

class ManifestNode {
  String title;
  List<ManifestNode> childs;
  List<ManifestProp> props;

  ManifestNode(this.title, this.childs, this.props);
}
