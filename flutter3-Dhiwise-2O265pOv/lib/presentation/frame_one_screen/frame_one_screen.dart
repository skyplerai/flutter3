import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class FrameOneScreen extends StatelessWidget {
  const FrameOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Container(
            height: SizeUtils.height,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 337.v),
            decoration: AppDecoration.fillGray,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 191.v,
                    width: 190.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(
                        95.h,
                      ),
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgImage,
                  height: 150.adaptSize,
                  width: 150.adaptSize,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 15.v),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
