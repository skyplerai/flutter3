import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';

class ConnectCctvScreen extends StatelessWidget {
  const ConnectCctvScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 384.h,
          padding: EdgeInsets.symmetric(
            horizontal: 31.h,
            vertical: 34.v,
          ),
          child: Column(
            children: [
              Text(
                "Connect CCTV",
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 43.v),
              _buildConnectCctvRowStatic(context),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildConnectCctvRowStatic(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomElevatedButton(
              text: "STATIC",
              margin: EdgeInsets.only(right: 15.h),
              onPressed: () {
                onTapStatic(context);
              },
            ),
          ),
          Expanded(
            child: CustomElevatedButton(
              text: "DDNS",
              margin: EdgeInsets.only(left: 15.h),
              onPressed: () {
                onTapDdns(context);
              },
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the staticScreen when the action is triggered.
  onTapStatic(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.staticScreen);
  }

  /// Navigates to the ddnsScreen when the action is triggered.
  onTapDdns(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.ddnsScreen);
  }
}
