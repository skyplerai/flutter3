import 'dart:convert';

NotificationLogResponse notificationLogResponseFromJson(String str) =>
    NotificationLogResponse.fromJson(json.decode(str));

String notificationLogResponseToJson(NotificationLogResponse data) =>
    json.encode(data.toJson());

class NotificationLogResponse {
  int? count;
  String? next;
  String? previous;
  List<NotificationLog>? results;

  NotificationLogResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory NotificationLogResponse.fromJson(Map<String, dynamic> json) => NotificationLogResponse(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: json["results"] == null
        ? []
        : List<NotificationLog>.from(json["results"].map((x) => NotificationLog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class NotificationLog {
  int? user;
  String? faceId;
  String? cameraName;
  String? detectedTime;
  bool? notificationSent;
  String? image;

  NotificationLog({
    this.user,
    this.faceId,
    this.cameraName,
    this.detectedTime,
    this.notificationSent,
    this.image,
  });

  factory NotificationLog.fromJson(Map<String, dynamic> json) => NotificationLog(
    user: json["user"],
    faceId: json["face_id"],
    cameraName: json["camera_name"],
    detectedTime: json["detected_time"],
    notificationSent: json["notification_sent"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "face_id": faceId,
    "camera_name": cameraName,
    "detected_time": detectedTime,
    "notification_sent": notificationSent,
    "image": image,
  };
}
