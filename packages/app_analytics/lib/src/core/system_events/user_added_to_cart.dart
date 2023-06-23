import 'event_item.dart';

mixin UserAddedToCart {
  String get id;

  String? get coupon;

  String get currency;

  double get value;

  List<EventItem> get items;
}
