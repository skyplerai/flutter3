import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import for handling links

import 'package:sriram_s_application3/Services/api_service.dart';
import 'package:sriram_s_application3/core/app_export.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_outlined_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'TermsAndConditionsCheckbox.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController nameEditTextController = TextEditingController();
  TextEditingController emailEditTextController = TextEditingController();
  TextEditingController passwordEditTextController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isChecked = false; // Checkbox state

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
                            bottom: 90,
                            left: 250,
                            child: Text(
                              "Create\nAccount",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  height: 1.1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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
                      SizedBox(height: 21.v),
                      TermsAndConditionsCheckbox(
                        isChecked: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value;
                          });
                        },
                      ),
                      SizedBox(height: 21.v),
                      _buildSignUpButton(context),
                      SizedBox(height: 30.v),
                      dividerOfOr(context),
                      SizedBox(height: 30.v),
                      _buildLoginButton(context),
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

  Widget dividerOfOr(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("OR"),
        ),
        Expanded(
          child: Divider(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a username';
        }
        return null;
      },
    );
  }

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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email address';
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        if (!RegExp(r'\d').hasMatch(value)) {
          return 'Password must contain at least one digit';
        }
        if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
          return 'Password must contain at least one special character';
        }
        return null;
      },
    );
  }


  ApiService apiService = ApiService();

  Widget _buildSignUpButton(BuildContext context) {
    return CustomOutlinedButton(
      text: "Sign up",
      onPressed: () async {
        if (!_formKey.currentState!.validate()) {
          // If form validation fails, show all errors in a single SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fix the errors in the form.'),
              backgroundColor: Colors.black,
            ),
          );
          return;
        }

        if (!_isChecked) {
          // Show error if checkbox is not checked
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please agree to the Terms and Conditions')),
          );
          return;
        }

        // Proceed with registration if both form is valid and checkbox is checked
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

  // Helper method to launch URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
