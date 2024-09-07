import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sriram_s_application3/constants/snack_bar.dart';
import 'package:sriram_s_application3/core/app_export.dart';
import '../../../Services/api_service.dart';
import '../login_screen/login_screen.dart';

class OtpPasswordScreen extends StatefulWidget {
  final String email;

  OtpPasswordScreen({required this.email});

  @override
  State<OtpPasswordScreen> createState() => _OtpPasswordScreenState();
}

class _OtpPasswordScreenState extends State<OtpPasswordScreen> {
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  ApiService apiService = ApiService();
  bool isLoading = false;
  bool isPasswordVisible = false; // Visibility toggle for new password
  bool isConfirmPasswordVisible = false; // Visibility toggle for confirm password
  final _formKey = GlobalKey<FormState>(); // Form key for validation

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
            'Enter OTP and New Password',
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

                // New Password Field with Visibility Toggle
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextField(
                      controller: passwordController,
                      cursorColor: Colors.orange,
                      obscureText: !isPasswordVisible, // Toggle visibility
                      decoration: InputDecoration(
                        labelText: 'New Password',
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: height * 0.02),

                // Confirm Password Field with Visibility Toggle
                StatefulBuilder(
                  builder: (context, setState) {
                    return TextField(
                      controller: confirmPassController,
                      cursorColor: Colors.orange,
                      obscureText: !isConfirmPasswordVisible, // Toggle visibility
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible = !isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: height * 0.04),

                // Form and Pinput for OTP
                Form(
                  key: _formKey,
                  child: Pinput(
                    controller: otpController,
                    length: 6,
                    defaultPinTheme: PinTheme(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length != 6) {
                        return 'Enter a valid 6-digit code';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: height * 0.04),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      if (passwordController.text.isEmpty ||
                          confirmPassController.text.isEmpty) {
                        showSnackBar("Please enter both passwords", context);
                        return;
                      }
                      if (passwordController.text != confirmPassController.text) {
                        showSnackBar("Passwords do not match", context);
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      //API call
                      // Capture the result of the password reset operation
                      try {
                        var response = await apiService.createNewPassword(
                          context,
                          email: widget.email,
                          new_password: passwordController.text,
                          confirmPassword: confirmPassController.text,
                          otp: otpController.text,
                        );

                        setState(() {
                          isLoading = false;
                        });

                        if (response['success']) {
                          // Password updated successfully, navigate to login screen
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()), // Your login screen
                                (Route<dynamic> route) => false, // Clear the stack
                          );
                        } else {
                          showSnackBar("Something went wrong: ${response['message']}", context);
                        }
                      } catch (error) {
                        setState(() {
                          isLoading = false;
                        });
                        showSnackBar("Error: $error", context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: width * 0.3),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                      "Submit",
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
