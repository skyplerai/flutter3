import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sriram_s_application3/Services/api_service.dart';
import 'package:sriram_s_application3/constants/style.dart';
import 'package:sriram_s_application3/core/app_export.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ApiService.emailVerify(context, otp: otpController.text);
        },
        backgroundColor: mainColor,
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: appTheme.black900,
        title: Text(
          "Verify email",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.h),
        child: Center(
          child: Pinput(
            controller: otpController,
            length: 6,
            defaultPinTheme: PinTheme(
                height: 55.h,
                width: 60.v,
                decoration: BoxDecoration(
                    color: theme.colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300))),
          ),
        ),
      ),
    );
  }
}
