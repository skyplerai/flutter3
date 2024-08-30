// lib/presentation/home_page_one_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sriram_s_application3/Services/shared_services.dart';
import 'package:sriram_s_application3/constants/stream_urls.dart';
import 'package:sriram_s_application3/presentation/ddns_screen/ddns_screen.dart';
import 'package:sriram_s_application3/presentation/static_screen/static_screen.dart';

import '../../constants/style.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/video_player/video_player.dart';

class HomePageOneScreen extends StatelessWidget {
  HomePageOneScreen({Key? key}) : super(key: key);

  int? selectedIndex;
  final streamUrlController = Get.put(StreamUrlController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  content: const Text('Do you want to exit the app?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'))
                  ]);
            });
      },
      child: GetBuilder<StreamUrlController>(
          init: StreamUrlController(),
          builder: (controller) {
            return SafeArea(
              child: Scaffold(
                appBar: _buildAppBar(context),
                body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 23.h,
                    vertical: 14.v,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Obx(() {
                          return Column(
                            children: List.generate(
                                streamUrlController.streamUrls.length, (index) {
                              return Column(
                                children: [
                                  if (index == 0) _buildRowCctv(context),
                                  SizedBox(height: 13.v),
                                  Container(
                                    height: 300.adaptSize,
                                    width: 500.adaptSize,
                                    padding: EdgeInsets.all(10.v),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(46, 45, 45, 1),
                                        borderRadius:
                                        BorderRadius.circular(20.v)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.v),
                                      child: WebSocketVideoPlayer(
                                        webSocketUrl: streamUrlController.streamUrls[index] ?? '',
                                        authToken: UserSharedServices.loginDetails()?.accessToken ?? '',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          );
                        }),
                        SizedBox(
                          height: 10.v,
                        ),
                        InkWell(
                          borderRadius: BorderRadiusStyle.roundedBorder18,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: Center(
                                      child: Text(
                                        "Connect CCTV",
                                        style: theme.textTheme.headlineSmall,
                                      ),
                                    ),
                                    content: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                      Colors.black,
                                                      content: StaticScreen(),
                                                    );
                                                  });
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: mainColor),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Static",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 25.v,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                      Colors.black,
                                                      content: DdnsScreen(),
                                                    );
                                                  });
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: mainColor),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Text(
                                                "DDNS",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Obx(() {
                            return _buildColumnOne(
                              context,
                              connectCCTVText: "Connect CCTV",
                              camerasCounterText:
                              "${streamUrlController.streamUrls.length} cameras",
                              tapToConnectText: "Tap to connect",
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildConnectButton(BuildContext context, {required String title}) {
    return CustomElevatedButton(
      height: 45.v,
      width: 129.h,
      text: title,
      buttonTextStyle: TextStyle(fontSize: 20, color: Colors.white),
      buttonStyle: ElevatedButton.styleFrom(backgroundColor: mainColor),
      margin: EdgeInsets.only(
        left: 80.h,
        right: 80.h,
        bottom: 22.v,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 84.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgImage,
        margin: EdgeInsets.only(left: 19.h),
      ),
      title: AppbarSubtitle(
        text:
        "${UserSharedServices.loginDetails()!.userInfo!.username.toString()}",
        margin: EdgeInsets.only(left: 10.h),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.notificationsScreen);
          },
          radius: 25,
          borderRadius: BorderRadius.circular(35),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRowCctv(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 6.h,
        right: 12.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "CCTV",
            style: theme.textTheme.titleLarge,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.v,
              bottom: 2.v,
            ),
            child: Text(
              "Credit : 7 days",
              style: theme.textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }

  bool isVideoConnected = false;

  Widget _buildColumnOne(
      BuildContext context, {
        required String connectCCTVText,
        required String camerasCounterText,
        required String tapToConnectText,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 13.h,
        vertical: 14.v,
      ),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder18,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    connectCCTVText,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: appTheme.whiteA700,
                    ),
                  ),
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgImage16x13,
                        height: 10.v,
                        width: 10.h,
                        margin: EdgeInsets.symmetric(vertical: 1.v),
                      ),
                      Text(
                        camerasCounterText,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: appTheme.whiteA700,
                        ),
                      )
                    ],
                  )
                ],
              ),
              CustomImageView(
                imagePath: ImageConstant.imgImage20x20,
                height: 15.adaptSize,
                width: 15.adaptSize,
                margin: EdgeInsets.only(
                  left: 4.h,
                  top: 4.v,
                  bottom: 23.v,
                ),
              )
            ],
          ),
          SizedBox(height: 11.v),
          Container(
            margin: EdgeInsets.only(right: 1.h),
            padding: EdgeInsets.symmetric(
              horizontal: 108.h,
              vertical: 78.v,
            ),
            decoration: AppDecoration.fillGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder14,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 2.v),
                Text(
                  tapToConnectText,
                  style: CustomTextStyles.titleMediumGray700.copyWith(
                    color: appTheme.gray700,
                  ),
                ),
                CustomIconButton(
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgImage30x30,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 21.v)
        ],
      ),
    );
  }

  void onTapColumnuserone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.notificationsScreen);
  }

  void onTapImgImagefourteen(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.databaseScreen);
  }
}