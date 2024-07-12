import 'package:flutter/material.dart';
import 'package:sriram_s_application3/Services/api_service.dart';
import 'package:sriram_s_application3/core/app_export.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_outlined_button.dart';
import '../../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameEditTextController = TextEditingController();

  TextEditingController emailEditTextController = TextEditingController();

  TextEditingController passwordEditTextController = TextEditingController();

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
                              "Create\nAccount",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  height: 1.1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Positioned(
                              top: 375,
                              left: 230,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 40,
                                  )))
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 250),
                  child: Column(
                    children: [
                      SizedBox(height: 25.v),
                      _buildSignInWithGoogleButton(context),
                      SizedBox(height: 19.v),
                      dividerOfOr(context),
                      SizedBox(height: 15.v),
                      _buildNameEditText(context),
                      SizedBox(height: 20.v),
                      _buildEmailEditText(context),
                      SizedBox(height: 21.v),
                      _buildPasswordEditText(context),
                      SizedBox(height: 14.v),
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
                      SizedBox(height: 21.v),
                      _buildSignUpButton(context),
                      SizedBox(height: 30.v),
                      dividerOfOr(context),
                      SizedBox(height: 30.v),
                      _buildLoginButton(context)
                    ],
                  ),
                )
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
  Widget _buildSignInWithGoogleButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Sign in with Google",
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.only(
        left: 53.h,
        right: 51.h,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 14.h),
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
  Widget _buildStackLine(BuildContext context) {
    return SizedBox(
      height: 24.v,
      width: 399.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 9.v),
              child: SizedBox(
                width: 399.h,
                child: Divider(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 18.v,
              width: 36.h,
              margin: EdgeInsets.only(bottom: 1.v),
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
  Widget _buildNameEditText(BuildContext context) {
    return CustomTextFormField(
      controller: nameEditTextController,
      hintText: "Username",
      prefix: Icon(
        Icons.person,
        color: Colors.grey,
        size: 30,
      ),
      contentPadding: EdgeInsets.only(right: 30.h, top: 10.h),
    );
  }

  /// Section Widget
  Widget _buildEmailEditText(BuildContext context) {
    return CustomTextFormField(
      controller: emailEditTextController,
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
  Widget _buildPasswordEditText(BuildContext context) {
    return CustomTextFormField(
      controller: passwordEditTextController,
      hintText: "Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      prefix: Icon(
        Icons.lock_outline,
        color: Colors.grey,
        size: 30,
      ),
      contentPadding: EdgeInsets.only(right: 30.h, top: 10.h),
      obscureText: true,
    );
  }

  ApiService apiService = ApiService();

  /// Section Widget
  Widget _buildSignUpButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Sign up",
      onPressed: () async {
        await apiService.register(
          context,
          email: emailEditTextController.text,
          password: passwordEditTextController.text,
          userName: nameEditTextController.text,
        );
      },
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.only(
        left: 52.h,
        right: 51.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildStackLineOne(BuildContext context) {
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
  Widget _buildLoginButton(BuildContext context) {
    return CustomOutlinedButton(
      width: 300.h,
      text: "Login",
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.only(
        left: 52.h,
        right: 51.h,
      ),
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      },
    );
  }
}
