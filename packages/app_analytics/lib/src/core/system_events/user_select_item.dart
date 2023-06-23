import 'event_item.dart';

mixin UserSelectItem {
  String get itemListId;

  String get itemListName;

  List<EventItem> get items;
}
