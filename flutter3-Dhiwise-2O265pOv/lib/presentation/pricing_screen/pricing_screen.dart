import 'package:flutter/material.dart';
import 'package:sriram_s_application3/constants/style.dart';
import 'package:sriram_s_application3/presentation/pricing_screen/payment_screen.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 250.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        shape: CustomShapeBorder(),
        flexibleSpace: Column(
          children: [
            SizedBox(
              height: 50.v,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30.h,
                    )),
                Text(
                  "Standard".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.v),
                ),
                SizedBox(
                  width: 55.v,
                )
              ],
            ),
            SizedBox(
              height: 40.v,
            ),
            Column(
              children: [
                Text(
                  "₹ 399.99".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 55.v),
                ),
                Text(
                  "Billed Monthly",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 20.v),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 60.v),
          Text(
            "Person detection",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 16.v),
          Divider(
            indent: 46.h,
            endIndent: 46.h,
            color: Colors.white,
          ),
          SizedBox(height: 17.v),
          Text(
            "Face Recognition",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 14.v),
          Divider(
            indent: 46.h,
            endIndent: 46.h,
            color: Colors.white,
          ),
          SizedBox(height: 15.v),
          Text(
            "Face Database",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 16.v),
          Divider(
            indent: 46.h,
            endIndent: 46.h,
            color: Colors.white,
          ),
          SizedBox(height: 17.v),
          Text(
            "Analytics",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 14.v),
          Divider(
            indent: 46.h,
            endIndent: 46.h,
            color: Colors.white,
          ),
          SizedBox(height: 18.v),
          Text(
            "30 days cloud storage",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 13.v),
          Divider(
            indent: 46.h,
            endIndent: 46.h,
            color: Colors.white,
          ),
          SizedBox(height: 15.v),
          Text(
            "Instant Notification",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 5.v)
        ],
      ),
      bottomNavigationBar: _buildGetStartedButton(context),
    );
  }

  /// Section Widget
  Widget _buildGetStartedButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        // Navigate to the UPI payment page when the button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpiTransactionPage(),
          ),
        );
      },
      height: 45.v,
      width: 180.h,
      buttonStyle: ElevatedButton.styleFrom(backgroundColor: mainColor),
      text: "Get Started",
      margin: EdgeInsets.only(
        left: 111.h,
        right: 105.h,
        bottom: 25.v,
      ),
      buttonTextStyle: CustomTextStyles.titleLargeBold,
    );
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addPath(
          super.getOuterPath(rect, textDirection: textDirection), Offset.zero)
      ..addPath(
          Path()
            ..moveTo(rect.width / 2, rect.height)
            ..lineTo(rect.width, rect.height)
            ..lineTo(rect.width, rect.height + 24) // Adjust the arrow size
            ..lineTo(rect.width / 2, rect.height + 48) // Adjust the arrow size
            ..lineTo(0, rect.height + 24) // Adjust the arrow size
            ..lineTo(0, rect.height)
            ..close(),
          Offset.zero);
  }
}
