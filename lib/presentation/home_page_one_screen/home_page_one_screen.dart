import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
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
          child: Column(
            children: [
              _buildRowCctv(context),
              SizedBox(height: 13.v),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: List.generate(
                              2,
                              (index) => ElevatedButton(
                                  onPressed: () {}, child: Text("Submit"))),
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
              SizedBox(height: 12.v),
              _buildColumnOne(
                context,
                connectCCTVText: "Connect CCTV",
                camerasCounterText: "0 cameras",
                tapToConnectText: "Tap to connect",
              ),
              SizedBox(height: 6.v)
            ],
          ),
        ),
        // bottomNavigationBar: _buildColumnTwo(context),
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
            style: theme.textTheme.headlineSmall,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.v,
              bottom: 2.v,
            ),
            child: Text(
              "Credit : 7 days",
              style: theme.textTheme.titleLarge,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnTwo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 28.h,
        right: 28.h,
        bottom: 7.v,
      ),
      decoration: AppDecoration.fillGray,
      child: CustomImageView(
        imagePath: ImageConstant.imgGroup,
        height: 50.v,
        width: 374.h,
        onTap: () {
          onTapImgImagefourteen(context);
        },
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
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: appTheme.whiteA700,
                    ),
                  ),
                  Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgImage16x13,
                        height: 16.v,
                        width: 13.h,
                        margin: EdgeInsets.symmetric(vertical: 1.v),
                      ),
                      Text(
                        camerasCounterText,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: appTheme.whiteA700,
                        ),
                      )
                    ],
                  )
                ],
              ),
              CustomImageView(
                imagePath: ImageConstant.imgImage20x20,
                height: 20.adaptSize,
                width: 20.adaptSize,
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
