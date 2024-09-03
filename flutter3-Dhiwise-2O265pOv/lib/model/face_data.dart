// lib/models/face_data.dart

class FaceCount {
  final String faceId;
  final int count;

  FaceCount({
    required this.faceId,
    required this.count,
  });

  factory FaceCount.fromJson(Map<String, dynamic> json) {
    return FaceCount(
      faceId: json['face_id'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'face_id': faceId,
      'count': count,
    };
  }
}

class FaceData {
  final int totalFaces;
  final int knownFaces;
  final int unknownFaces;
  final List<FaceCount> faceCounts;

  FaceData({
    required this.totalFaces,
    required this.knownFaces,
    required this.unknownFaces,
    required this.faceCounts,
  });

  factory FaceData.fromJson(Map<String, dynamic> json) {
    return FaceData(
      totalFaces: json['total_faces'],
      knownFaces: json['known_faces'],
      unknownFaces: json['unknown_faces'],
      faceCounts: (json['face_counts'] as List)
          .map((face) => FaceCount.fromJson(face))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_faces': totalFaces,
      'known_faces': knownFaces,
      'unknown_faces': unknownFaces,
      'face_counts': faceCounts.map((face) => face.toJson()).toList(),
    };
  }
}
