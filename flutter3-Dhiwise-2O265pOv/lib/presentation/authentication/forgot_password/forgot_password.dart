import 'package:flutter/material.dart';
import 'package:sriram_s_application3/constants/snack_bar.dart';
import 'package:sriram_s_application3/core/app_export.dart';
import '../../../Services/api_service.dart';
import 'OtpPasswordScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen();

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  ApiService apiService = ApiService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black12,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Text(
                  "Enter your email to reset password",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.03),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                  ),
                ),
                SizedBox(height: height * 0.04),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        showSnackBar("Please enter an email address", context);
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      final response = await apiService.sendOtpToEmail(
                        context,
                        email: emailController.text,
                      );
                      if (response) {
                        // Navigate to OTP page if OTP is sent successfully
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpPasswordScreen(
                              email: emailController.text,
                            ),
                          ),
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 34, horizontal: width * 0.3),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                      "Send OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
