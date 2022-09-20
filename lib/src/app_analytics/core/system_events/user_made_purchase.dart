import 'user_added_to_cart.dart';

mixin UserMadePurchase {
  String get transactionId;

  double get value;

  double? get tax;

  String get currency;

  String? get coupon;

  List<CartItem> get items;
}
