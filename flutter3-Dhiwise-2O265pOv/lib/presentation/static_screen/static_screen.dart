// lib/presentation/static_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sriram_s_application3/Services/api_service.dart';
import 'package:sriram_s_application3/constants/snack_bar.dart';
import '../../constants/stream_urls.dart';
import '../../constants/style.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class StaticScreen extends StatelessWidget {
  StaticScreen({Key? key}) : super(key: key);

  TextEditingController ipnetworkvalueController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ApiService apiService = ApiService();

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
          Padding(
            padding: EdgeInsets.only(
              left: 3.h,
              right: 4.h,
            ),
            child: CustomTextFormField(
              controller: ipnetworkvalueController,
              hintText: "IP Network",
              prefix: Container(
                margin: EdgeInsets.only(
                  left: 3.h,
                  right: 26.h,
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
            obscureText: false,
            contentPadding: EdgeInsets.only(top: 0.v),
          ),
          SizedBox(height: 10.v),
          StatefulBuilder(builder:
              (BuildContext context, void Function(void Function()) setState) {
            return CustomTextFormField(
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
              suffix: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
//               obscureText: !_passwordVisible,
              obscureText: !_passwordVisible,
              contentPadding: EdgeInsets.only(top: 10),
            );
          }),
          SizedBox(height: 25.v),
          _buildConnectButton(context)
        ],
      ),
    );
  }

  final streamUrlController = Get.put(StreamUrlController());

  Widget _buildConnectButton(BuildContext context) {
    return CustomElevatedButton(
      height: 45.v,
      width: 129.h,
      text: "Connect",
      buttonTextStyle: TextStyle(fontSize: 20, color: Colors.white),
      buttonStyle: ElevatedButton.styleFrom(backgroundColor: mainColor),
      margin: EdgeInsets.only(
        left: 80.h,
        right: 80.h,
        bottom: 22.v,
      ),
      onPressed: () async {
        try {
          final response = await apiService.addStaticCamera(
            password: passwordController.text,
            ipAddress: ipnetworkvalueController.text,
            username: usernameController.text,
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            final streamUrlsResponse =
                await apiService.getStreamUrl("static"); // or "ddns"
            final urls = streamUrlsResponse.streamUrls;
            streamUrlController.streamUrls
                .addAll(urls.map((url) => url.url).toList());
            showSnackBar(jsonDecode(response.body)['message'], context);
            Navigator.pop(context);
          } else {
            showSnackBar("Something went wrong.", context);
            Navigator.pop(context);
          }
        } catch (e) {
          showSnackBar("Error: $e", context);
        }
      },
    );
  }
}
