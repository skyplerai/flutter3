import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SinglePerson extends StatefulWidget {
  final String name;

  SinglePerson({required this.name});

  @override
  _SinglePersonState createState() => _SinglePersonState();
}

class _SinglePersonState extends State<SinglePerson> {
  String selectedPeriod = 'Week'; // Default selection
  final double fontSize = 18.0; // Custom font size
  final Color underlineColor = Colors.orange; // Custom underline color

  @override
  Widget build(BuildContext context) {
    // Example data: 7 days of entries
    final List<int> entries = [3, 7, 5, 8, 2, 4, 6];
    final int totalVisits = entries.reduce((a, b) => a + b); // Calculate total visitors

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(10, 20, 10, 0.1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10), // Vertical gap
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPeriodButton('Week'),
                  _buildPeriodButton('Month'),
                  _buildPeriodButton('Year'),
                ],
              ),
            ),
            SizedBox(height: 20), // Vertical gap between period buttons and chart

            SizedBox(height: 16), // Spacing between the chart and the label
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.orange, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: Text(
                'Total No of Visits: $totalVisits',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String period) {
    bool isSelected = selectedPeriod == period;
    return TextButton(
      onPressed: () {
        setState(() {
          selectedPeriod = period;
        });
      },
      child: Text(
        period,
        style: TextStyle(
          color: isSelected ? Colors.orange : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize,
          decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
          decorationColor: isSelected ? underlineColor : Colors.transparent, // Custom underline color
        ),
      ),
    );
  }
}
