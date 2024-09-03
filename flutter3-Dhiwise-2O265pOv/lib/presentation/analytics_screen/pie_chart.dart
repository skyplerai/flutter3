import 'package:flutter/material.dart';
import 'package:sriram_s_application3/core/app_export.dart';
import '../../model/face_data.dart';
import '../../services/api_service.dart';

class AprilAnalyticsWidget extends StatefulWidget {
  const AprilAnalyticsWidget({Key? key}) : super(key: key);

  @override
  _AprilAnalyticsWidgetState createState() => _AprilAnalyticsWidgetState();
}

class _AprilAnalyticsWidgetState extends State<AprilAnalyticsWidget> {
  late Future<FaceData> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchDetectedFaces(); // Initialize _futureData here
  }

  Future<FaceData> _fetchDetectedFaces() async {
    final apiService = ApiService();
    final response = await apiService.getFaceAnalytics();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FaceData>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          final faceData = snapshot.data!;
          final totalPeople = faceData.totalFaces;
          final knownPeople = faceData.knownFaces;
          final unknownPeople = faceData.unknownFaces;

          // Check to avoid division by zero
          double knownPercentage = totalPeople > 0 ? knownPeople / totalPeople : 0.0;
          double unknownPercentage = totalPeople > 0 ? unknownPeople / totalPeople : 0.0;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: ResponsiveExtension(17).h),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveExtension(19).h,
              vertical: 30.v,
            ),
            decoration: AppDecoration.fillBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder27,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.v),
                SizedBox(height: 25.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          final percentage = (knownPercentage * 100).toStringAsFixed(2);
                          final Upercentage = (unknownPercentage * 100).toStringAsFixed(2);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.orange,
                                content: Text(
                                  'Known People: $percentage%, \n'
                                      'Unknown People: $Upercentage%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 150.adaptSize,
                              width: 150.adaptSize,
                              child: CircularProgressIndicator(
                                value: knownPercentage,
                                strokeWidth: 55,
                                backgroundColor: appTheme.yellow90002,
                                color: appTheme.red600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 18.v,
                        bottom: 8.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Total People",
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            "${totalPeople.toInt()}",
                            style: CustomTextStyles.titleLarge22,
                          ),
                          SizedBox(height: 9.v),
                          Text(
                            "Unknown People",
                            style: theme.textTheme.titleSmall,
                          ),
                          SizedBox(height: 1.v),
                          Text(
                            "${unknownPeople.toInt()}",
                            style: CustomTextStyles.titleLarge22,
                          ),
                          SizedBox(height: 9.v),
                          Text(
                            "Known People",
                            style: theme.textTheme.titleSmall,
                          ),
                          SizedBox(height: 1.v),
                          Padding(
                            padding: EdgeInsets.only(right: ResponsiveExtension(3).h),
                            child: Text(
                              "${knownPeople.toInt()}",
                              style: CustomTextStyles.titleLarge22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 21.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(left: ResponsiveExtension(10).h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: ResponsiveExtension(125).h,
                          child: Text(
                            "Number of People Entered",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.titleSmall14,
                          ),
                        ),
                        Spacer(flex: 63),
                        SizedBox(
                          width: ResponsiveExtension(75).h,
                          child: Text(
                            "Unknown People",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.titleSmallYellow90001,
                          ),
                        ),
                        Spacer(flex: 18),
                        SizedBox(
                          width: ResponsiveExtension(70).h,
                          child: Text(
                            "Known People",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.titleSmallRed600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
