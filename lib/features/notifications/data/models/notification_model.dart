import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {

  final String id;

  final String type;

  final String title;

  final String body;

  final Map<String, dynamic>? data;

  @JsonKey(name: 'action_url')
  final String? actionUrl;

  @JsonKey(name: 'read_at')
  final String? readAt;

  @JsonKey(name: 'created_at')
  final String createdAt;


  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.data,
    this.actionUrl,
    this.readAt,
    required this.createdAt,
  });


  factory NotificationModel.fromJson(
      Map<String,dynamic> json,
      ) =>
      _$NotificationModelFromJson(json);


  Map<String,dynamic> toJson() =>
      _$NotificationModelToJson(this);


  bool get isRead => readAt != null;


  NotificationModel copyWith({
    String? id,
    String? type,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    String? actionUrl,
    String? readAt,
    String? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      actionUrl: actionUrl ?? this.actionUrl,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}



