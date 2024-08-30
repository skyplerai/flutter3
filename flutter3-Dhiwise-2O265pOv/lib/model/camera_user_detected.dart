// lib/model/camera_detected_users.dart

import 'dart:convert';

CameraDetectedUsers cameraDetectedUsersFromJson(String str) =>
    CameraDetectedUsers.fromJson(json.decode(str));

String cameraDetectedUsersToJson(CameraDetectedUsers data) =>
    json.encode(data.toJson());

class CameraDetectedUsers {
  int? count;
  String? next;
  String? previous;
  List<DetectedFace>? results;

  CameraDetectedUsers({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory CameraDetectedUsers.fromJson(Map<String, dynamic> json) =>
      CameraDetectedUsers(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<DetectedFace>.from(
            json["results"]!.map((x) => DetectedFace.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": results == null
        ? []
        : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class DetectedFace {
  int? id;
  int? user;
  String? faceId;
  String? image;
  String? lastSeen;

  DetectedFace({
    this.id,
    this.user,
    this.faceId,
    this.image,
    this.lastSeen,
  });

  factory DetectedFace.fromJson(Map<String, dynamic> json) => DetectedFace(
    id: json["id"],
    user: json["user"],
    faceId: json["face_id"],
    image: json["image"],
    lastSeen: json["last_seen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "face_id": faceId,
    "image": image,
    "last_seen": lastSeen,
  };
}