import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // ignore: must_be_immutable

class ViewhierarchyItemWidget extends StatelessWidget {
  const ViewhierarchyItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 106.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 137.v,
          width: 106.h,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgImage,
                height: 99.v,
                width: 106.h,
                alignment: Alignment.topCenter,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 23.h,
                    right: 9.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgImage2,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                        alignment: Alignment.centerRight,
                      ),
                      Text(
                        "1:25 PM",
                        style: theme.textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
