import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sriram_s_application3/core/app_export.dart';

import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 396.h,
          padding: EdgeInsets.symmetric(vertical: 34.v),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5.v),
              _buildAppBar(context),
              Expanded(
                child: _buildFAQList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// AppBar Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          "FAQ",
          style: TextStyle(color: Colors.white), // Optional: Change text color if needed
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.01),  // Set the background color to grey
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }


  /// FAQ List Widget
  Widget _buildFAQList() {
    final List<Map<String, String>> faqItems = [
      {
        "question": "What is The Third Eye?",
        "answer": "The Third Eye is an advanced monitoring app designed to help you keep an eye on your home through the CCTV cameras that are already installed at your property. With real-time video streaming and face detection capabilities, you can monitor your home’s security from anywhere using your mobile device.",
      },
      {
        "question": "How do I create an account?",
        "answer": "You can easily create an account by signing in with your email address or using Google sign-in. Just choose your preferred method on the login screen and follow the instructions to complete the registration process.",
      },
      {
        "question": "How can I reset my password?",
        "answer": "If you forget your password, you can reset it by clicking on the 'Forgot Password' link on the login page. You will receive an email with instructions on how to set a new password and regain access to your account.",
      },
      {
        "question": "What should I do if the app crashes or doesn’t start?",
        "answer": "If the app crashes or doesn’t start, try reinstalling the app. If the problem continues, please report the issue to our tech support team by sending an email detailing the problem. Our team will assist you in resolving the issue.",
      },
      {
        "question": "What subscription plans are available?",
        "answer": "The Third Eye offers a single subscription plan that includes all features. This plan provides full access to the app’s capabilities for a monthly fee.",
      },
      // Add more FAQ items as needed...
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.v, vertical: 16.v),
      itemCount: faqItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                faqItems[index]["question"]!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 8.v),
              Text(
                faqItems[index]["answer"]!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        );
      },
    );
  }
}
