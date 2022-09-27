import 'event_item.dart';

mixin UserViewItem {
  String? get itemListId;

  String? get itemListName;

  List<EventItem>? get items;
}
