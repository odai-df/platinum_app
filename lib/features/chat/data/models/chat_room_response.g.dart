// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomResponse _$ChatRoomResponseFromJson(Map<String, dynamic> json) =>
    ChatRoomResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ChatRoomData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatRoomResponseToJson(ChatRoomResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ChatRoomData _$ChatRoomDataFromJson(Map<String, dynamic> json) => ChatRoomData(
      id: (json['id'] as num?)?.toInt(),
      clientId: (json['client_id'] as num?)?.toInt(),
      employeeId: (json['employee_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ChatRoomDataToJson(ChatRoomData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_id': instance.clientId,
      'employee_id': instance.employeeId,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
