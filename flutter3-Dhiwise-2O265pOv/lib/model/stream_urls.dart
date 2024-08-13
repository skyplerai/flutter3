//lib/model/stream_urls.dart
import 'dart:convert';

class StreamUrl {
  final int id;
  final String name;
  final String url;

  StreamUrl({required this.id, required this.name, required this.url});

  factory StreamUrl.fromJson(Map<String, dynamic> json) {
    return StreamUrl(
      id: json['id'],
      name: json['name'],
      url: json['url'],
    );
  }
}

class StreamUrls {
  final List<StreamUrl> streamUrls;

  StreamUrls({required this.streamUrls});

  factory StreamUrls.fromJson(Map<String, dynamic> json) {
    var list = json['stream_urls'] as List;
    List<StreamUrl> urlsList = list.map((i) => StreamUrl.fromJson(i)).toList();

    return StreamUrls(streamUrls: urlsList);
  }
}

StreamUrls streamUrlsFromJson(String str) {
  final jsonData = json.decode(str);
  return StreamUrls.fromJson(jsonData);
}