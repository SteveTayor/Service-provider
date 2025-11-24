class AllNotificationResponse {
  final String? status;
  final List<Notfication>? notifications;

  AllNotificationResponse({
    this.status,
    this.notifications,
  });

  factory AllNotificationResponse.fromJson(Map<String, dynamic> json) =>
      AllNotificationResponse(
        status: json["status"] as String?,
        notifications: json["notifications"] == null
            ? []
            : (json['notifications'] as List<dynamic>)
                .map((e) => Notfication.fromJson(e as Map<String, dynamic>))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notfication {
  final String? id;
  final String? type;
  final String? notifiableType;
  final int? notifiableId;
  final Data? data;
  final DateTime? readAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Notfication({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Notfication.fromJson(Map<String, dynamic> json) => Notfication(
        id: json["id"] as String?,
        type: json["type"] as String?,
        notifiableType: json["notifiable_type"] as String?,
        notifiableId: json["notifiable_id"] as int?,
        data: json["data"] == null
            ? null
            : Data.fromJson(json["data"] as Map<String, dynamic>),
        readAt: json["read_at"] == null
            ? null
            : DateTime.parse(json["read_at"] as String),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"] as String),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data?.toJson(),
        "read_at": readAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Data {
  final String? message;
  final String? type;

  Data({
    this.message,
    this.type,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"] as String?,
        type: json["type"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "type": type,
      };
}
