import 'package:bond_core/src/core/core.dart';

mixin UserViewItem {
  String? get currency;

  double? get value;

  List<EventItem>? get items;
}
