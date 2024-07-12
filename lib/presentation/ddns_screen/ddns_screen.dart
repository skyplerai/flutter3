import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sriram_s_application3/constants/style.dart';

import '../../Services/api_service.dart';
import '../../constants/snack_bar.dart';
import '../../constants/stream_urls.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class DdnsScreen extends StatelessWidget {
  DdnsScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController hostnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Connect CCTV",
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 34.v),
          CustomTextFormField(
            controller: hostnameController,
            hintText: "DDNS Hostname",
            prefix: Container(
              margin: EdgeInsets.only(
                left: 3.h,
                right: 25.h,
                bottom: 10.v,
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgImage30x27,
                height: 30.v,
                width: 27.h,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 40.v,
            ),
            contentPadding: EdgeInsets.only(
              top: 1.v,
              right: 30.h,
              bottom: 1.v,
            ),
          ),
          SizedBox(height: 12.v),
          CustomTextFormField(
            controller: usernameController,
            hintText: "Username",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            prefix: Container(
              margin: EdgeInsets.only(
                left: 3.h,
                right: 25.h,
                bottom: 10.v,
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 28.h,
              ),
            ),
            prefixConstraints: BoxConstraints(maxHeight: 53.v),
            obscureText: true,
            contentPadding: EdgeInsets.only(top: 0.v),
          ),
          SizedBox(height: 10.v),
          CustomTextFormField(
            controller: passwordController,
            hintText: "Password",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            prefix: Container(
              margin: EdgeInsets.only(
                left: 3.h,
                right: 25.h,
                bottom: 10.v,
              ),
              child: Icon(
                Icons.lock,
                color: Colors.white,
                size: 28.h,
              ),
            ),
            prefixConstraints: BoxConstraints(maxHeight: 53.v),
            suffix: Icon(
              Icons.visibility_off_outlined,
              color: Colors.white,
            ),
            obscureText: true,
            contentPadding: EdgeInsets.only(top: 0.v),
          ),
          SizedBox(height: 25.v),
          _buildConnectButton(context)
        ],
      ),
    );
  }

  ApiService apiService = ApiService();
  final streamUrlController = Get.put(StreamUrlController());

  /// Section Widget
  Widget _buildConnectButton(BuildContext context) {
    return CustomElevatedButton(
      height: 45.v,
      width: 129.h,
      text: "Connect",
      onPressed: () async {
        final response = await apiService.addDDNSCamera(
            password: passwordController.text,
            ipAddress: hostnameController.text,
            username: usernameController.text);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final streamUrl = await apiService.getStreamUrl("ddns");
          print("streamUrl ${streamUrl}");
          streamUrlController.streamUrls.add(streamUrl);
          showSnackBar(jsonDecode(response.body)['message'], context);
          streamUrlController.getAllTheUrls();
          Navigator.pop(context);
        } else {
          showSnackBar("Something went wrong.", context);
          Navigator.pop(context);
        }
      },
      buttonTextStyle: TextStyle(fontSize: 20, color: Colors.white),
      buttonStyle: ElevatedButton.styleFrom(backgroundColor: mainColor),
      margin: EdgeInsets.only(
        left: 80.h,
        right: 80.h,
        bottom: 22.v,
      ),
    );
  }
}
