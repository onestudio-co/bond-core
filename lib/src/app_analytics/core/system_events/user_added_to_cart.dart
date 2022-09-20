mixin UserAddedToCart {
  String get id;

  String? get coupon;

  String get currency;

  double get value;

  List<CartItem> get items;
}

class CartItem {
  final String id;
  final String name;
  final String? category;
  final int quantity;
  final double price;
  final String currency;

  CartItem(
      {required this.id,
      required this.name,
      required this.quantity,
      this.category,
      required this.price,
      required this.currency});
}
