import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/notifications_item_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key})
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
            horizontal: 18.h,
            vertical: 5.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  "Notification",
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 13.v),
              Container(
                width: 114.h,
                margin: EdgeInsets.only(left: 11.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 30.h,
                  vertical: 2.v,
                ),
                decoration: AppDecoration.fillBlueGray.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder14,
                ),
                child: Text(
                  "All",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 13.v),
              _buildNotifications(context)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 62.v,
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.fromLTRB(29.h, 16.v, 387.h, 17.v),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildNotifications(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.h),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 86.v,
          crossAxisCount: 3,
          mainAxisSpacing: 9.h,
          crossAxisSpacing: 9.h,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 13,
        itemBuilder: (context, index) {
          return NotificationsItemWidget();
        },
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
