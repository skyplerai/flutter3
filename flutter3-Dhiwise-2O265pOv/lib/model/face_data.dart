class FaceData {
  final String date;
  final int totalFaces;
  final int knownFaces;
  final int unknownFaces;
  final int knownFacesToday;
  final int knownFacesWeek;
  final int knownFacesMonth;
  final int knownFacesYear;
  final Map<String, int> faceCount;

  FaceData({
    required this.date,
    required this.totalFaces,
    required this.knownFaces,
    required this.unknownFaces,
    required this.knownFacesToday,
    required this.knownFacesWeek,
    required this.knownFacesMonth,
    required this.knownFacesYear,
    required this.faceCount,
  });

  factory FaceData.fromJson(Map<String, dynamic> json) {
    // Parse the facecount field safely
    Map<String, int> parsedFaceCount = {};
    if (json['facecount'] != null) {
      parsedFaceCount = Map<String, int>.from(json['facecount']);
    }

    return FaceData(
      date: json['date'],
      totalFaces: json['total_faces'],
      knownFaces: json['known_faces'],
      unknownFaces: json['unknown_faces'],
      knownFacesToday: json['known_faces_today'],
      knownFacesWeek: json['known_faces_week'],
      knownFacesMonth: json['known_faces_month'],
      knownFacesYear: json['known_faces_year'],
      faceCount: parsedFaceCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'total_faces': totalFaces,
      'known_faces': knownFaces,
      'unknown_faces': unknownFaces,
      'known_faces_today': knownFacesToday,
      'known_faces_week': knownFacesWeek,
      'known_faces_month': knownFacesMonth,
      'known_faces_year': knownFacesYear,
      'facecount': faceCount,
    };
  }
}
