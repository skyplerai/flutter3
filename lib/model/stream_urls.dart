// To parse this JSON data, do
//
//     final streamUrls = streamUrlsFromJson(jsonString);

import 'dart:convert';

StreamUrls streamUrlsFromJson(String str) =>
    StreamUrls.fromJson(json.decode(str));

String streamUrlsToJson(StreamUrls data) => json.encode(data.toJson());

class StreamUrls {
  List<String>? streamUrls;

  StreamUrls({
    this.streamUrls,
  });

  factory StreamUrls.fromJson(Map<String, dynamic> json) => StreamUrls(
        streamUrls: json["stream_urls"] == null
            ? []
            : List<String>.from(json["stream_urls"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "stream_urls": streamUrls == null
            ? []
            : List<dynamic>.from(streamUrls!.map((x) => x)),
      };
}
