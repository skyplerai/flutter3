import 'package:flutter/material.dart';
import 'package:sriram_s_application3/presentation/analytics_screen/analytics_screen.dart';
import 'package:sriram_s_application3/presentation/database_screen/database_screen.dart';
import 'package:sriram_s_application3/presentation/home_page_one_screen/home_page_one_screen.dart';
import 'package:sriram_s_application3/presentation/settings_screen/settings_screen.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen();

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedIndex = 0;

  final screens = [
    HomePageOneScreen(),
    AnalyticsScreen(),
    DatabaseScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
            onTap: (int) {
              setState(() {
                selectedIndex = int;
              });
            },
            currentIndex: selectedIndex,
            enableFeedback: false,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            useLegacyColorScheme: false,
            fixedColor: Colors.white,
            unselectedFontSize: 1,
            selectedFontSize: 1,
            unselectedIconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            iconSize: 40,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_sharp), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '')
            ]),
      ),
    );
  }
}
