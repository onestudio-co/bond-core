import 'event_item.dart';

mixin UserViewedItemList {
  String? get itemListId;

  String? get itemListName;

  List<EventItem>? get items;
}
