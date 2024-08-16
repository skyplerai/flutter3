// lib/model/camera_detected_users.dart

import 'dart:convert';

CameraDetectedUsers cameraDetectedUsersFromJson(String str) =>
    CameraDetectedUsers.fromJson(json.decode(str));

String cameraDetectedUsersToJson(CameraDetectedUsers data) =>
    json.encode(data.toJson());

class CameraDetectedUsers {
  int? count;
  dynamic next;
  dynamic previous;
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
  String? imagePath;
  String? lastSeen;
  String? imageUrl;

  DetectedFace({
    this.id,
    this.user,
    this.faceId,
    this.imagePath,
    this.lastSeen,
    this.imageUrl,
  });

  factory DetectedFace.fromJson(Map<String, dynamic> json) => DetectedFace(
    id: json["id"],
    user: json["user"],
    faceId: json["face_id"],
    imagePath: json["image_path"],
    lastSeen: json["last_seen"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "face_id": faceId,
    "image_path": imagePath,
    "last_seen": lastSeen,
    "image_url": imageUrl,
  };
}