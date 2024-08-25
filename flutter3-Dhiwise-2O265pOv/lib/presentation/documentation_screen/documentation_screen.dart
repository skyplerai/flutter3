import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class DocumentationScreen extends StatelessWidget {
  const DocumentationScreen({Key? key})
      : super(
          key: key,
        );

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
              Expanded(
                child: _buildAppBar(context),
              ),
            ],
          ),
        ),
      ),
    );
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          "How to SetUp",
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
}
