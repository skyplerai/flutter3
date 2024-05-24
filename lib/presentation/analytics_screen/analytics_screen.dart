import 'package:flutter/material.dart';

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
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 7.v),
          child: Column(
            children: [
              SizedBox(height: 9.v),
              _buildColumnApril(context),
              Spacer()
            ],
          ),
        ),
      ),
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
  Widget _buildColumnApril(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.h),
      padding: EdgeInsets.symmetric(
        horizontal: 19.h,
        vertical: 25.v,
      ),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder27,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.v),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Row(
              children: [
                CustomDropDown(
                  width: 70.h,
                  hintText: "8",
                  hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                  textStyle: TextStyle(fontSize: 14, color: Colors.black),
                  items: dropdownItemList,
                  contentPadding:
                      EdgeInsets.only(left: 15.h, top: 7.5.h, bottom: 7.5.h),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 9.h),
                  child: CustomDropDown(
                    width: 150.h,
                    hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    textStyle: TextStyle(fontSize: 14, color: Colors.black),
                    contentPadding:
                        EdgeInsets.only(left: 10.h, top: 7.5.h, bottom: 7.5.h),
                    icon: Container(
                      margin: EdgeInsets.symmetric(horizontal: 13.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgArrowdown,
                        height: 3.v,
                        width: 8.h,
                      ),
                    ),
                    hintText: "April",
                    items: dropdownItemList1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 9.h),
                  child: CustomDropDown(
                    width: 90.h,
                    hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                    textStyle: TextStyle(fontSize: 14, color: Colors.black),
                    contentPadding:
                        EdgeInsets.only(left: 15.h, top: 7.5.h, bottom: 7.5.h),
                    icon: Container(
                      margin: EdgeInsets.symmetric(horizontal: 13.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgArrowdown,
                        height: 3.v,
                        width: 8.h,
                      ),
                    ),
                    hintText: "2023",
                    items: dropdownItemList2,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 19.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: SizedBox(
                  height: 150.adaptSize,
                  width: 150.adaptSize,
                  child: CircularProgressIndicator(
                    value: 0.4,
                    strokeWidth: 55,
                    backgroundColor: appTheme.yellow90002,
                    color: appTheme.red600,
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
                      "Total  People",
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      "192",
                      style: CustomTextStyles.titleLarge22,
                    ),
                    SizedBox(height: 9.v),
                    Text(
                      "Unknown People",
                      style: theme.textTheme.titleSmall,
                    ),
                    SizedBox(height: 1.v),
                    Text(
                      "107",
                      style: CustomTextStyles.titleLarge22,
                    ),
                    SizedBox(height: 9.v),
                    Text(
                      "Known People",
                      style: theme.textTheme.titleSmall,
                    ),
                    SizedBox(height: 1.v),
                    Padding(
                      padding: EdgeInsets.only(right: 3.h),
                      child: Text(
                        "85",
                        style: CustomTextStyles.titleLarge22,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 21.v),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 125.h,
                    child: Text(
                      "Number of People  Entered",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmall14,
                    ),
                  ),
                  Spacer(
                    flex: 63,
                  ),
                  SizedBox(
                    width: 75.h,
                    child: Text(
                      "Unknown People",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallYellow90001,
                    ),
                  ),
                  Spacer(
                    flex: 18,
                  ),
                  SizedBox(
                    width: 70.h,
                    child: Text(
                      "Known \nPeople ",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallRed600,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

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
