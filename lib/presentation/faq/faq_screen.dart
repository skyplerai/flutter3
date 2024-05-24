import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sriram_s_application3/core/app_export.dart';

import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 396.h,
          padding: EdgeInsets.symmetric(vertical: 34.v),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [SizedBox(height: 5.v), _buildAppBar(context)],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 41.v,
      centerTitle: true,
      title: AppbarTitle(
        text: "FAQ",
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30.h,
          )),
    );
  }
}
