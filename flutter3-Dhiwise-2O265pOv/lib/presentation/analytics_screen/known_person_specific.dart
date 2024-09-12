import 'package:flutter/material.dart';
import 'package:sriram_s_application3/core/app_export.dart';
import 'single_person.dart';
import '../../model/face_data.dart';
import '../../services/api_service.dart';

class KnownPersonSpecific extends StatefulWidget {
  @override
  _KnownPersonSpecificState createState() => _KnownPersonSpecificState();
}

class _KnownPersonSpecificState extends State<KnownPersonSpecific> {
  late Future<List<FaceCount>> _futureKnownFaces;

  @override
  void initState() {
    super.initState();
    _futureKnownFaces = _fetchKnownFaces();
  }

  Future<List<FaceCount>> _fetchKnownFaces() async {
    final apiService = ApiService();
    final faceData = await apiService.getFaceAnalytics();
    // Filter out only known faces (excluding any face with "unknown" in faceId)
    return faceData.faceCounts.where((face) => !face.faceId.startsWith("unknown")).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FaceCount>>(
      future: _futureKnownFaces,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            color: Colors.orange,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Container(
              margin: EdgeInsets.all(20), // Margin around the container
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding inside the container
              decoration: BoxDecoration(
                color: Colors.grey[850], // Background color of the container
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Text(
                'There are no known faces available here',
                textAlign: TextAlign.center, // Center align text
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          final knownFaces = snapshot.data!;
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.h,
              vertical: 20.v,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 20.v,
            ),
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder27,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Known peoples:-",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 15),
                ...knownFaces.map((face) => _buildPersonEntry(context, face.faceId, face.count.toString())).toList(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildPersonEntry(BuildContext context, String name, String entryCount) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => SinglePerson(name: name)),
      //   );
      // },
      child: Container(
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
