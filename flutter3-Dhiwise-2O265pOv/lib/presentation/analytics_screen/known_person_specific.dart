import 'package:flutter/material.dart';
import 'package:sriram_s_application3/core/app_export.dart';
import '../../model/face_data.dart';
import '../../services/api_service.dart';

class KnownPersonSpecific extends StatefulWidget {
  @override
  _KnownPersonSpecificState createState() => _KnownPersonSpecificState();
}

class _KnownPersonSpecificState extends State<KnownPersonSpecific> {
  late Future<FaceData> _futureFaceData;

  @override
  void initState() {
    super.initState();
    _futureFaceData = _fetchKnownFaces();
  }

  Future<FaceData> _fetchKnownFaces() async {
    final apiService = ApiService();
    final faceData = await apiService.getFaceAnalytics();
    return faceData; // Directly return the FaceData object
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FaceData>(
      future: _futureFaceData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'No face data available',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          final faceData = snapshot.data!;
          final knownFacesCount = faceData.knownFaces;
          final faceCountMap = faceData.faceCount;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder27,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Known people count: $knownFacesCount",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 15),
                if (knownFacesCount > 0) ...[
                  // Iterating over the faceCount map to display each person
                  for (var entry in faceCountMap.entries)
                    _buildPersonEntry(
                      context,
                      entry.key, // Person's name
                      entry.value.toString(), // Person's count
                    ),
                ] else ...[
                  Center(
                    child: Text(
                      "There are no known faces available here.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildPersonEntry(BuildContext context, String name, String entryCount) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(ImageConstant.imgImage),
              radius: 40,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Total No. of Entries $entryCount',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
