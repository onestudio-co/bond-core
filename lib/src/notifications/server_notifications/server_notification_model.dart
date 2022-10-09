class ServerNotificationModel {
  final String id;
  final String tile;
  final String body;
  final String deepLink;
  final String code;
  final DateTime? readAt;

  ServerNotificationModel({
    required this.id,
    required this.tile,
    required this.body,
    required this.deepLink,
    required this.code,
    required this.readAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tile': tile,
      'body': body,
      'deep_link': deepLink,
      'code': code,
      'read_at': readAt,
    };
  }

  factory ServerNotificationModel.fromMap(Map<String, dynamic> map) {
    return ServerNotificationModel(
      id: map['id'] as String,
      tile: map['tile'] as String,
      body: map['body'] as String,
      deepLink: map['deep_link'] as String,
      code: map['code'] as String,
      readAt: map['read_at'] as DateTime,
    );
  }
}

enum SeverNotificationChangedType { load, read, readAll }
