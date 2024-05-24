import 'package:flutter/material.dart';
import 'package:sriram_s_application3/presentation/ddns_screen/ddns_screen.dart';
import 'package:sriram_s_application3/presentation/static_screen/static_screen.dart';

import '../../constants/style.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';

class HomePageOneScreen extends StatelessWidget {
  const HomePageOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
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
              children: List.generate(5, (index) {
                return Column(
                  children: [
                    index == 0 ? _buildRowCctv(context) : SizedBox(),
                    SizedBox(height: 13.v),
                    InkWell(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.black,
                                                  content: StaticScreen(),
                                                );
                                              });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: mainColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                                  backgroundColor: Colors.black,
                                                  content: DdnsScreen(),
                                                );
                                              });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: mainColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                      child: _buildColumnOne(
                        context,
                        connectCCTVText: "Connect CCTV",
                        camerasCounterText: "0 cameras",
                        tapToConnectText: "Tap to connect",
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        // bottomNavigationBar: _buildColumnTwo(context),
      ),
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

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 84.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgImage,
        margin: EdgeInsets.only(left: 19.h),
      ),
      title: AppbarSubtitle(
        text: "Mythiresh",
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

  /// Section Widget
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

  /// Common widget
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

  /// Navigates to the notificationsScreen when the action is triggered.
  onTapColumnuserone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.notificationsScreen);
  }

  /// Navigates to the databaseScreen when the action is triggered.
  onTapImgImagefourteen(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.databaseScreen);
  }
}
