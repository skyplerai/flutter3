import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sriram_s_application3/constants/snack_bar.dart';
import 'package:sriram_s_application3/presentation/faq/faq_screen.dart';
import 'package:sriram_s_application3/presentation/help_support/help_support.dart';

import '../../Services/shared_services.dart';
import '../../core/app_export.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray900,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 30.h,
            vertical: 17.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: 34.v),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgImage,
                    height: 85.v,
                    width: 89.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 14.h,
                      top: 15.v,
                      bottom: 12.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${UserSharedServices.loginDetails()!.userInfo!.username}",
                          style: CustomTextStyles.titleMediumSemiBold,
                        ),
                        Text(
                          "Chennai, Tamil Nadu",
                          style: theme.textTheme.bodyMedium,
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 47.v),
              Padding(
                padding: EdgeInsets.only(left: 9.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage36x36,
                      height: 36.adaptSize,
                      width: 36.adaptSize,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.ipAddressScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 13.h,
                          top: 2.v,
                          bottom: 3.v,
                        ),
                        child: Text(
                          "IP Address",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 32.v),
              Padding(
                padding: EdgeInsets.only(left: 7.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgDocument,
                      height: 36.adaptSize,
                      width: 36.adaptSize,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.documentationScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15.h,
                          top: 2.v,
                          bottom: 3.v,
                        ),
                        child: Text(
                          "Documentation",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 32.v),
              Padding(
                padding: EdgeInsets.only(left: 7.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage2,
                      height: 36.adaptSize,
                      width: 36.adaptSize,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.pricingScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15.h,
                          top: 5.v,
                        ),
                        child: Text(
                          "Pricing",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 36.v),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageConstant.imgGroup,
                      height: 33.adaptSize,
                      width: 33.adaptSize,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelpAndSupportScreen()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.h),
                        child: Text(
                          "Help and Support",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 35.v),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage33x33,
                      height: 36.adaptSize,
                      width: 36.adaptSize,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FAQScreen()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 14.h),
                        child: Text(
                          "FAQ",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 36.v),
              InkWell(
                onTap: () async {
                  showSnackBar("Logged out successfully.", context);
                  await preferences!.clear();
                  await UserSharedServices.logout();
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.authWrapperScreen);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgArrowDown,
                        height: 33.adaptSize,
                        width: 33.adaptSize,
                        margin: EdgeInsets.only(bottom: 1.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.h),
                        child: Text(
                          "Logout",
                          style: theme.textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.v),
              CustomImageView(
                imagePath: "assets/images/logo.png",
                height: 142.v,
                width: 152.h,
                alignment: Alignment.center,
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }
}
