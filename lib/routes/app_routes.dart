import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/analytics_screen/analytics_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/database_screen/database_screen.dart';
import '../presentation/home_page_one_screen/home_page_one_screen.dart';
import '../presentation/home_page_two_screen/home_page_two_screen.dart';
import '../presentation/notifications_screen/notifications_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String homePageOneScreen = '/home_page_one_screen';

  static const String homePageTwoScreen = '/home_page_two_screen';

  static const String databaseScreen = '/database_screen';

  static const String analyticsScreen = '/analytics_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    homePageOneScreen: (context) => HomePageOneScreen(),
    homePageTwoScreen: (context) => HomePageTwoScreen(),
    databaseScreen: (context) => DatabaseScreen(),
    analyticsScreen: (context) => AnalyticsScreen(),
    notificationsScreen: (context) => NotificationsScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    initialRoute: (context) => HomePageOneScreen()
  };
}
