
class CustomObject {
  CustomObject();

  Map<String, dynamic> toJson() {
    return {'hello': 'world'};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomObject && runtimeType == other.runtimeType;
}
