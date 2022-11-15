import 'package:json_annotation/json_annotation.dart';

part 'server_notification_model.g.dart';

@JsonSerializable()
class ServerNotificationModel {
  final String uuid;
  @JsonKey(name: 'notifiable_type')
  final String notifiableType;
  @JsonKey(name: 'notifiable_id')
  final int notifiableId;
  @JsonKey(name: 'authable_type')
  final String authableType;
  @JsonKey(name: 'authable_id')
  final int authableId;
  final String code;
  final String body;
  final Map<String, dynamic> data;
  @JsonKey(name: 'sender_name')
  final String? senderName;
  @JsonKey(name: 'sender_image')
  final String? senderImage;
  @JsonKey(name: 'read_at')
  final DateTime? readAt;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const ServerNotificationModel({
    required this.createdAt,
    required this.uuid,
    required this.code,
    required this.body,
    this.senderName,
    this.senderImage,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    this.readAt,
    required this.authableType,
    required this.authableId,
  });

  bool get getIsRead => readAt != null;

  factory ServerNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ServerNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServerNotificationModelToJson(this);
}

enum SeverNotificationChangedType { load, read, readAll }
