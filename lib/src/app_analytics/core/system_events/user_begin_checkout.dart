import 'event_item.dart';

mixin UserBeginCheckout {
  String? get coupon;

  String get currency;

  double get value;

  List<EventItem> get items;
}
