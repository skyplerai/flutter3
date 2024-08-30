import 'package:flutter/material.dart';

import '../../Services/shared_services.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/video_player/video_player.dart';

class HomePageTwoScreen extends StatelessWidget {
  const HomePageTwoScreen({Key? key})
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
              Container(
                height: 500.adaptSize,
                width: 500.adaptSize,
                child: WebSocketVideoPlayer(
                  webSocketUrl: "",
                  authToken: UserSharedServices.loginDetails()?.accessToken ?? '',
                ),
              ),
              SizedBox(height: 12.v),
              _buildColumnOne(
                context,
                connectCCTVText: "Connect CCTV",
                camerasCounterText: "0 cameras",
                imageThirteen: ImageConstant.imgImage1,
              ),
              SizedBox(height: 6.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildColumnTwo(context),
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
        GestureDetector(
          onTap: () {
            onTapColumnuserone(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 19.h,
              vertical: 5.v,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 13.h,
              vertical: 14.v,
            ),
            decoration: AppDecoration.outlineWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder27,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 1.v),
                AppbarImage(
                  imagePath: ImageConstant.imgUser,
                  margin: EdgeInsets.only(
                    left: 3.h,
                    right: 2.h,
                  ),
                ),
                AppbarImage(
                  imagePath: ImageConstant.imgClose,
                  margin: EdgeInsets.only(left: 20.h),
                ),
                SizedBox(height: 17.v),
                AppbarImage(
                  imagePath: ImageConstant.imgVector,
                  margin: EdgeInsets.symmetric(horizontal: 12.h),
                )
              ],
            ),
          ),
        )
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
      ),
    );
  }

  /// Common widget
  Widget _buildColumnOne(
      BuildContext context, {
        required String connectCCTVText,
        required String camerasCounterText,
        required String imageThirteen,
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
          CustomImageView(
            imagePath: imageThirteen,
            height: 213.v,
            width: 357.h,
            radius: BorderRadius.circular(
              14.h,
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
}