import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class NotificationsItemWidget extends StatelessWidget {
  const NotificationsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgImage85x89,
      height: 85.v,
      width: 89.h,
      radius: BorderRadius.circular(
        39.h,
      ),
    );
  }
}
