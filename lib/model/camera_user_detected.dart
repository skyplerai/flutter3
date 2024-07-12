// To parse this JSON data, do
//
//     final cameraDetectedUsers = cameraDetectedUsersFromJson(jsonString);

import 'dart:convert';

CameraDetectedUsers cameraDetectedUsersFromJson(String str) =>
    CameraDetectedUsers.fromJson(json.decode(str));

String cameraDetectedUsersToJson(CameraDetectedUsers data) =>
    json.encode(data.toJson());

class CameraDetectedUsers {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

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
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
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

class Result {
  int? id;
  String? name;
  String? embedding;
  String? createdAt;

  Result({
    this.id,
    this.name,
    this.embedding,
    this.createdAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        embedding: json["embedding"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "embedding": embedding,
        "created_at": createdAt,
      };
}
