class EventItem {
  final String? affiliation;
  final String? currency;
  final String? coupon;
  final String? creativeName;
  final String? creativeSlot;
  final num? discount;
  final int? index;
  final String? itemBrand;
  final String? itemCategory;
  final String? itemCategory2;
  final String? itemCategory3;
  final String? itemCategory4;
  final String? itemCategory5;
  final String? itemId;
  final String? itemListId;
  final String? itemListName;
  final String? itemName;
  final String? itemVariant;
  final String? locationId;
  final num? price;
  final String? promotionId;
  final String? promotionName;
  final int? quantity;

  EventItem({
    this.affiliation,
    this.currency,
    this.coupon,
    this.creativeName,
    this.creativeSlot,
    this.discount,
    this.index,
    this.itemBrand,
    this.itemCategory,
    this.itemCategory2,
    this.itemCategory3,
    this.itemCategory4,
    this.itemCategory5,
    this.itemId,
    this.itemListId,
    this.itemListName,
    this.itemName,
    this.itemVariant,
    this.locationId,
    this.price,
    this.promotionId,
    this.promotionName,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'affiliation': affiliation,
      'currency': currency,
      'coupon': coupon,
      'creativeName': creativeName,
      'creativeSlot': creativeSlot,
      'discount': discount,
      'index': index,
      'itemBrand': itemBrand,
      'itemCategory': itemCategory,
      'itemCategory2': itemCategory2,
      'itemCategory3': itemCategory3,
      'itemCategory4': itemCategory4,
      'itemCategory5': itemCategory5,
      'itemId': itemId,
      'itemListId': itemListId,
      'itemListName': itemListName,
      'itemName': itemName,
      'itemVariant': itemVariant,
      'locationId': locationId,
      'price': price,
      'promotionId': promotionId,
      'promotionName': promotionName,
      'quantity': quantity,
    };
  }

  factory EventItem.fromMap(Map<String, dynamic> map) {
    return EventItem(
      affiliation: map['affiliation'] as String,
      currency: map['currency'] as String,
      coupon: map['coupon'] as String,
      creativeName: map['creativeName'] as String,
      creativeSlot: map['creativeSlot'] as String,
      discount: map['discount'] as num,
      index: map['index'] as int,
      itemBrand: map['itemBrand'] as String,
      itemCategory: map['itemCategory'] as String,
      itemCategory2: map['itemCategory2'] as String,
      itemCategory3: map['itemCategory3'] as String,
      itemCategory4: map['itemCategory4'] as String,
      itemCategory5: map['itemCategory5'] as String,
      itemId: map['itemId'] as String,
      itemListId: map['itemListId'] as String,
      itemListName: map['itemListName'] as String,
      itemName: map['itemName'] as String,
      itemVariant: map['itemVariant'] as String,
      locationId: map['locationId'] as String,
      price: map['price'] as num,
      promotionId: map['promotionId'] as String,
      promotionName: map['promotionName'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
