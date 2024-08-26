import 'package:flutter/material.dart';
import 'package:sriram_s_application3/core/app_export.dart';
import 'single_person.dart';

class KnownPersonSpecific extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 20.v,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 20.v
      ),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder27,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Known peoples:-",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 15),
          _buildPersonEntry(context, "Sriram", "140"),
          SizedBox(height: 10),
          _buildPersonEntry(context, "Kishor", "100"),
          // Add more entries here if needed
        ],
      ),
    );
  }
  Widget _buildPersonEntry(BuildContext context, String name, String entryCount) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SinglePerson(name: name)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(ImageConstant.imgImage),
              radius: 40,
              backgroundColor: Colors.transparent, // No background color
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Total No. of Entries $entryCount',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
