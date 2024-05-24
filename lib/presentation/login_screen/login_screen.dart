import 'package:flutter/material.dart';
import 'package:sriram_s_application3/presentation/create_account_screen/create_account_screen.dart';

import '../../constants/style.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailSectionController = TextEditingController();

  TextEditingController passwordSectionController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onBackground,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Positioned(
                    top: -350,
                    left: -200,
                    child: CircleAvatar(
                      radius: 300.h,
                      backgroundColor: mainColor,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 80,
                            left: 275,
                            child: Text(
                              "Welcome\nBack",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  height: 1.1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Positioned(
                          //     top: 375,
                          //     left: 230,
                          //     child: IconButton(
                          //         onPressed: () {
                          //           Navigator.pop(context);
                          //         },
                          //         icon: Icon(
                          //           Icons.arrow_back_ios,
                          //           color: Colors.white,
                          //           size: 40,
                          //         )))
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 300),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4.v),
                      _buildSignInWithSection(context),
                      SizedBox(height: 26.v),
                      dividerOfOr(context),
                      SizedBox(height: 25.v),
                      _buildEmailSection(context),
                      SizedBox(height: 24.v),
                      _buildPasswordSection(context),
                      SizedBox(height: 18.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.h),
                          child: Text(
                            "Forgot password?",
                            style: CustomTextStyles.bodyLargePrimary,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.v),
                      _buildLogInSection(context),
                      SizedBox(height: 11.v),
                      dividerOfOr(context),
                      SizedBox(height: 10.v),
                      _buildSignUpSection(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dividerOfOr(context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          child: Divider(
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("OR"),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.40,
          child: Divider(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSignInWithSection(BuildContext context) {
    return CustomOutlinedButton(
      text: "Sign in with Google",
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.only(
        left: 52.h,
        right: 50.h,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 13.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgGoogle,
          height: 26.v,
          width: 25.h,
        ),
      ),
      buttonTextStyle: theme.textTheme.titleSmall!,
    );
  }

  /// Section Widget
  Widget _buildEmailSection(BuildContext context) {
    return CustomTextFormField(
      controller: emailSectionController,
      hintText: "Email address",
      textInputType: TextInputType.emailAddress,
      prefix: Icon(
        Icons.email_outlined,
        color: Colors.grey,
        size: 30,
      ),
      contentPadding: EdgeInsets.only(right: 30.h, top: 10.h),
    );
  }

  /// Section Widget
  Widget _buildPasswordSection(BuildContext context) {
    return CustomTextFormField(
      controller: passwordSectionController,
      hintText: "Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      prefix: Icon(
        Icons.lock_outline,
        color: Colors.grey,
        size: 30,
      ),
      contentPadding: EdgeInsets.only(right: 30.h, top: 10.h),
      suffix: Icon(
        Icons.visibility_off_outlined,
        color: Colors.grey,
        size: 30,
      ),
      obscureText: true,
    );
  }

  /// Section Widget
  Widget _buildLogInSection(BuildContext context) {
    return CustomOutlinedButton(
      text: "Log in",
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.dashboardScreen);
      },
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.only(
        left: 52.h,
        right: 50.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildOrOneSection(BuildContext context) {
    return SizedBox(
      height: 24.v,
      width: 399.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 399.h,
              child: Divider(),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 18.v,
              width: 36.h,
              margin: EdgeInsets.only(top: 2.v),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "OR",
              style: CustomTextStyles.bodyLargeSecondaryContainer,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSignUpSection(BuildContext context) {
    return CustomOutlinedButton(
      text: "Sign up",
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateAccountScreen()));
      },
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.only(
        left: 52.h,
        right: 50.h,
      ),
    );
  }
}
