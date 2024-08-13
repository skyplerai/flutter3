// lib/presentation/database_screen/viewhierarchy_item_widget.dart
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class ViewhierarchyItemWidget extends StatelessWidget {
  final String name;
  final String createdAt;
  final bool isKnown;
  final Function onRename;

  const ViewhierarchyItemWidget({
    Key? key,
    required this.name,
    required this.createdAt,
    required this.isKnown,
    required this.onRename,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 106.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 110.v,
          width: 95.h,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgImage,
                height: 80.v,
                width: 90.h,
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
                        createdAt,
                        style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                      Text(
                        name,
                        style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => onRename(),
                            child: Text(
                              isKnown ? "Known" : "Unknown",
                              style: TextStyle(color: isKnown ? Colors.orange : Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
