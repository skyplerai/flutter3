import 'package:flutter/material.dart';
import 'package:sriram_s_application3/core/app_export.dart';
import 'single_person.dart'; // Import the new page

class KnownPersonSpecific extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.h, vertical: 17.h),
      padding: EdgeInsets.symmetric(
        horizontal: 19.h,
        vertical: 30.v,
      ),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder27,
      ),
      child: Container(
        child: GestureDetector( // Wrap the Text widget with GestureDetector or InkWell
          onTap: () {
            // Navigate to the NextPage when the text is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SinglePerson()),
            );
          },
          child: Text(
            "Known Persons",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      )
    );

  }
}
