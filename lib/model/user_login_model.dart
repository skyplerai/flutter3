// To parse this JSON data, do
//
//     final userLoginModel = userLoginModelFromJson(jsonString);

import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) =>
    UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserInfo? userInfo;
  String? accessToken;
  String? refreshToken;
  List<dynamic>? streamUrls;

  UserLoginModel({
    this.userInfo,
    this.accessToken,
    this.refreshToken,
    this.streamUrls,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
        userInfo: json["user_info"] == null
            ? null
            : UserInfo.fromJson(json["user_info"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        streamUrls: json["stream_urls"] == null
            ? []
            : List<dynamic>.from(json["stream_urls"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "user_info": userInfo?.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "stream_urls": streamUrls == null
            ? []
            : List<dynamic>.from(streamUrls!.map((x) => x)),
      };
}

class UserInfo {
  String? username;
  String? email;

  UserInfo({
    this.username,
    this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
      };
}
