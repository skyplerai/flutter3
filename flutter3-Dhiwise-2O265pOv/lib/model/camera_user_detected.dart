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
  double? qualityScore;
  bool? isKnown;
  String? dateSeen;
  int? totalVisits;
  List<FaceVisit>? faceVisits;

  DetectedFace({
    this.id,
    this.user,
    this.faceId,
    this.qualityScore,
    this.isKnown,
    this.dateSeen,
    this.totalVisits,
    this.faceVisits,
  });

  factory DetectedFace.fromJson(Map<String, dynamic> json) => DetectedFace(
    id: json["id"],
    user: json["user"],
    faceId: json["face_id"],
    qualityScore: json["quality_score"]?.toDouble(),
    isKnown: json["is_known"],
    dateSeen: json["date_seen"],
    totalVisits: json["total_visits"],
    faceVisits: json["face_visits"] == null
        ? []
        : List<FaceVisit>.from(
        json["face_visits"]!.map((x) => FaceVisit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "face_id": faceId,
    "quality_score": qualityScore,
    "is_known": isKnown,
    "date_seen": dateSeen,
    "total_visits": totalVisits,
    "face_visits": faceVisits == null
        ? []
        : List<dynamic>.from(faceVisits!.map((x) => x.toJson())),
  };
}

class FaceVisit {
  String? detectedTime;
  String? image;

  FaceVisit({
    this.detectedTime,
    this.image,
  });

  factory FaceVisit.fromJson(Map<String, dynamic> json) => FaceVisit(
    detectedTime: json["detected_time"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "detected_time": detectedTime,
    "image": image,
  };
}