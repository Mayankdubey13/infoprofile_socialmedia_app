class ApiResponseNotificationsModel {
  final int? statusCode;
  final String? type;
  final List<Notification>? data;

  ApiResponseNotificationsModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });

  factory ApiResponseNotificationsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data']['notifications'] as List;
    List<Notification> notifications =
    data.map((item) => Notification.fromJson(item)).toList();

    return ApiResponseNotificationsModel(
      statusCode: json['statusCode'],
      type: json['type'],
      data: notifications,
    );
  }
}

class Notification {
  final String? id;
  final String? senderId;
  final String? receiverId;
  final String? message;
  final String? type;
  final String? actionId;
  final bool? status;
  final bool? read;
  final String? createdAt;
  final NotificationData? notificationData;

  Notification({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.type,
    required this.actionId,
    required this.status,
    required this.read,
    required this.createdAt,
    required this.notificationData,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      type: json['type'],
      actionId: json['actionId'],
      status: json['status'],
      read: json['read'],
      createdAt: json['createdAt'],
      notificationData: NotificationData.fromJson(json['notification_data']),
    );
  }
}

class NotificationData {
  final String? name;
  final String? userName;
  final String? displayPicture;
  final int? v;

  NotificationData({
    required this.name,
    required this.userName,
    required this.displayPicture,
    required this.v,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      name: json['name'],
      userName: json['userName'],
      displayPicture: json['displayPicture'],
      v: json['__v'],
    );
  }
}