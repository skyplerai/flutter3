import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sriram_s_application3/constants/snack_bar.dart';
import 'package:sriram_s_application3/core/app_export.dart';

import '../../../Services/api_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen();

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  ApiService apiService = ApiService();
  bool isOtpSent = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onBackground,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        backgroundColor: theme.colorScheme.onBackground,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Enter your email to reset password")),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final response = await apiService.sendOtpToEmail(context,
                          email: emailController.text);
                      if (response) {
                        setState(() {
                          isOtpSent = true;
                        });
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isOtpSent ? Colors.grey : Colors.orange),
                    child: Padding(
                      padding: EdgeInsets.all(12.adaptSize),
                      child: isLoading
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              "Send Otp",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.adaptSize),
                            ),
                    )),
                SizedBox(
                  height: 100.h,
                ),
                isOtpSent
                    ? TextField(
                        controller: passwordController,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Enter new password',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 15.h,
                ),
                isOtpSent
                    ? TextField(
                        controller: confirmPassController,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 25.h,
                ),
                isOtpSent
                    ? Pinput(
                        controller: otpController,
                        length: 6,
                        defaultPinTheme: PinTheme(
                            height: 55.h,
                            width: 60.v,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey.shade300))),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 25.h,
                ),
                isOtpSent
                    ? ElevatedButton(
                        onPressed: () async {
                          if (passwordController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty &&
                              passwordController.text ==
                                  confirmPassController.text) {
                            await apiService.createNewPassword(context,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPassController.text,
                                otp: otpController.text);
                          } else {
                            showSnackBar("Passwords do not match.", context);
                          }
                          emailController.clear();
                          passwordController.clear();
                          confirmPassController.clear();
                          otpController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        child: Padding(
                          padding: EdgeInsets.all(12.adaptSize),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.adaptSize),
                          ),
                        ))
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
