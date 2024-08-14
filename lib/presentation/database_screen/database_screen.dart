import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import 'widgets/viewhierarchy_item_widget.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class DatabaseScreen extends StatelessWidget {
  DatabaseScreen({Key? key})
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
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 39.v),
              Column(
                children: [
                  _buildRowDatabase(context),
                  SizedBox(height: 22.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 29.h),
                      child: Row(
                        children: [
                          CustomDropDown(
                            width: 70.h,
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black),
                            textStyle:
                                TextStyle(fontSize: 14, color: Colors.black),
                            contentPadding: EdgeInsets.only(
                                left: 15.h, top: 7.5.h, bottom: 7.5.h),
                            items: dropdownItemList,
                            icon: Container(
                              margin: EdgeInsets.symmetric(horizontal: 13.h),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgArrowdown,
                                height: 3.v,
                                width: 8.h,
                              ),
                            ),
                            hintText: "8",
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 9.h),
                            child: CustomDropDown(
                              width: 140.h,
                              hintStyle:
                                  TextStyle(fontSize: 13, color: Colors.black),
                              textStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              contentPadding: EdgeInsets.only(
                                  left: 10.h, top: 7.5.h, bottom: 7.5.h),
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
                              width: 95.h,
                              hintStyle:
                                  TextStyle(fontSize: 13, color: Colors.black),
                              textStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              contentPadding: EdgeInsets.only(
                                  left: 15.h, top: 7.5.h, bottom: 7.5.h),
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
                  ),
                  SizedBox(height: 24.v),
                  _buildRowUnknownCount(context),
                  SizedBox(height: 27.v),
                  _buildViewHierarchy(context),
                  SizedBox(height: 24.v),
                  _buildRowSriram(context),
                  SizedBox(height: 27.v),
                  _buildViewHierarchy(context),
                  SizedBox(height: 24.v),
                  _buildRowUnknownCount(context),
                  SizedBox(height: 27.v),
                  _buildViewHierarchy(context),
                  // _buildTabBarView(context)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowDatabase(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 29.h,
        right: 24.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.v),
            child: Text(
              "Database",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          CustomIconButton(
            height: 47.v,
            width: 51.h,
            padding: EdgeInsets.all(12.h),
            onTap: () {
              onTapBtnIconbutton(context);
            },
            child: Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildKnown(BuildContext context) {
    return CustomElevatedButton(
      width: 71.h,
      text: "Known",
      margin: EdgeInsets.only(
        top: 3.v,
        bottom: 2.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildUnknown(BuildContext context) {
    return CustomElevatedButton(
      width: 71.h,
      text: "Unknown",
      margin: EdgeInsets.only(
        left: 2.h,
        top: 3.v,
        bottom: 2.v,
      ),
      buttonStyle: CustomButtonStyles.fillYellow,
    );
  }

  /// Section Widget
  Widget _buildRowUnknownCount(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 29.h,
        right: 17.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Unknown 101",
            style: CustomTextStyles.titleMediumSemiBold17,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage20x20,
            height: 15.adaptSize,
            width: 15.adaptSize,
            margin: EdgeInsets.only(
              left: 10.h,
              top: 8.v,
              bottom: 6.v,
            ),
          ),
          Spacer(),
          _buildKnown(context),
          CustomImageView(
            imagePath: ImageConstant.imgImage29x23,
            height: 20.v,
            width: 23.h,
            margin: EdgeInsets.only(
              left: 2.h,
              top: 3.v,
              bottom: 2.v,
            ),
          ),
          _buildUnknown(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildViewHierarchy(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 110.v,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 15.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 0.h,
            );
          },
          itemCount: 7,
          itemBuilder: (context, index) {
            return ViewhierarchyItemWidget();
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowSriram(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.h,
        right: 18.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Sriram",
            style: CustomTextStyles.titleMediumSemiBold17,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage20x20,
            height: 15.adaptSize,
            width: 15.adaptSize,
            margin: EdgeInsets.only(
              left: 8.h,
              top: 8.v,
              bottom: 6.v,
            ),
          ),
          Spacer(),
          // Container(
          //   height: 29.v,
          //   width: 169.h,
          //   margin: EdgeInsets.only(top: 4.v),
          //   child: TabBar(
          //     controller: tabviewController,
          //     labelPadding: EdgeInsets.zero,
          //     labelColor: appTheme.whiteA700,
          //     labelStyle: TextStyle(
          //       fontSize: 12.fSize,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w600,
          //     ),
          //     unselectedLabelColor: appTheme.whiteA700,
          //     unselectedLabelStyle: TextStyle(
          //       fontSize: 12.fSize,
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w600,
          //     ),
          //     indicatorSize: TabBarIndicatorSize.tab,
          //     indicator: BoxDecoration(
          //       color: appTheme.yellow900,
          //       borderRadius: BorderRadius.circular(
          //         14.h,
          //       ),
          //     ),
          //     tabs: [
          //       Tab(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             CustomElevatedButton(
          //               width: 71.h,
          //               text: "Known",
          //               buttonStyle: CustomButtonStyles.fillYellow,
          //             ),
          //             CustomImageView(
          //               imagePath: ImageConstant.imgImage29x23,
          //               height: 29.v,
          //               width: 23.h,
          //               margin: EdgeInsets.only(left: 2.h),
          //             )
          //           ],
          //         ),
          //       ),
          //       Tab(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             CustomImageView(
          //               imagePath: ImageConstant.imgImage29x23,
          //               height: 29.v,
          //               width: 23.h,
          //             ),
          //             CustomElevatedButton(
          //               width: 71.h,
          //               text: "Unknown",
          //               margin: EdgeInsets.only(left: 2.h),
          //             )
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // )
          _buildKnown(context),
          CustomImageView(
            imagePath: ImageConstant.imgImage29x23,
            height: 20.v,
            width: 23.h,
            margin: EdgeInsets.only(
              left: 2.h,
              top: 3.v,
              bottom: 2.v,
            ),
          ),
          _buildUnknown(context)
        ],
      ),
    );
  }

  /// Navigates to the notificationsScreen when the action is triggered.
  onTapBtnIconbutton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.notificationsScreen);
  }
}
