class UnreadCountResponse {
  final String? status;
  final String? message;
  final UnreadCountData? data;

  UnreadCountResponse({
    this.status,
    this.message,
    this.data,
  });

  factory UnreadCountResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return UnreadCountResponse(
      status: json['status'],
      message: json['message'],
      data:
          json['data'] != null ? UnreadCountData.fromJson(json['data']) : null,
    );
  }
}

class UnreadCountData {
  final int unreadCount;

  UnreadCountData({
    required this.unreadCount,
  });

  factory UnreadCountData.fromJson(
    Map<String, dynamic> json,
  ) {
    return UnreadCountData(
      unreadCount: json['unread_count'] ?? 0,
    );
  }
}
