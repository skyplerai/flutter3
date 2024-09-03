import 'package:flutter/material.dart';
import 'package:sriram_s_application3/presentation/analytics_screen/known_person_specific.dart';
import 'package:sriram_s_application3/presentation/analytics_screen/pie_chart.dart';

import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart'; // ignore_for_file: must_be_immutable



// ignore_for_file: must_be_immutable
class AnalyticsScreen extends StatelessWidget {
  AnalyticsScreen({Key? key})
      : super(
          key: key,
        );

  List<String> dropdownItemList =
      List<String>.generate(31, (index) => (index + 1).toString());

  List<String> dropdownItemList1 = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> dropdownItemList2 = ["2024", "2025", "2026"];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 7.v),
          child: Column(
            children: [
              SizedBox(height:9.v),
              AprilAnalyticsWidget(),
              KnownPersonSpecific(),
            ],
          ),
        ),
      ),
    )
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 69.v,
      centerTitle: true,
      title: AppbarTitle(
        text: "Analytics",
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgImage,
          margin: EdgeInsets.symmetric(
            horizontal: 27.h,
            vertical: 1.v,
          ),
        )
      ],
    );
  }

  /// Section Widget


  ///Section Widget



  /// Section Widget
  Widget _buildColumn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapColumn(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 7.v),
        padding: EdgeInsets.symmetric(horizontal: 27.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgGroup,
          height: 50.v,
          width: 374.h,
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the databaseScreen when the action is triggered.
  onTapColumn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.databaseScreen);
  }
}
