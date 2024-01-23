import 'package:bond_core/bond_core.dart';

class FakeJsonable with Jsonable {
  FakeJsonable();

  @override
  Map<String, dynamic> toJson() {
    return {'hello': 'world'};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FakeJsonable && runtimeType == other.runtimeType;
}
