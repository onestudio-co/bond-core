import 'event_item.dart';

mixin UserMadePurchase {
  String get currency;

  String? get coupon;

  double get value;

  double get tax;

  double get shipping;

  String get transactionId;

  String? get affiliation;

  List<EventItem> get items;
}
