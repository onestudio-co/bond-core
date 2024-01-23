class NotRegisteredModel {
  final String data;

  NotRegisteredModel._(this.data);

  factory NotRegisteredModel.fromJson(Map<String, dynamic> json) {
    return NotRegisteredModel._(json['data']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotRegisteredModel &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}
