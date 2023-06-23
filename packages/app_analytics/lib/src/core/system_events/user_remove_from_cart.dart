import 'event_item.dart';

mixin UserRemovedFromCart {
  String get id;

  String? get coupon;

  String get currency;

  double get value;

  List<EventItem> get items;
}
