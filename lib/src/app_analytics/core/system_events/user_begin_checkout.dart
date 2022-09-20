import 'user_added_to_cart.dart';

mixin UserBeginCheckout {
  String get coupon;

  String get currency;

  double get value;

  List<CartItem> get items;
}
