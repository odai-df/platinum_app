import 'package:json_annotation/json_annotation.dart';

import 'notification_model.dart';


part 'notifications_response.g.dart';


@JsonSerializable()
class NotificationsResponse {

  final String? status;

  final String? message;

  final List<NotificationModel>? data;


  NotificationsResponse({
    this.status,
    this.message,
    this.data,
  });


  factory NotificationsResponse.fromJson(
      Map<String,dynamic> json,
      ) =>
      _$NotificationsResponseFromJson(json);


  Map<String,dynamic> toJson() =>
      _$NotificationsResponseToJson(this);
}