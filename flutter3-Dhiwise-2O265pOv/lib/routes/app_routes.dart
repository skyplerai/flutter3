import 'package:flutter/material.dart';
import 'package:sriram_s_application3/presentation/authentication/verify_email/verify_email.dart';
import 'package:sriram_s_application3/presentation/dashboard/dashboard.dart';
import 'package:sriram_s_application3/presentation/splash_screen/splash_screen.dart';

import '../constants/connect_cctv_screen.dart';
import '../presentation/analytics_screen/analytics_screen.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/authentication/auth_wrapper/auth_wrapper.dart';
import '../presentation/authentication/create_account_screen/create_account_screen.dart';
import '../presentation/authentication/forgot_password/forgot_password.dart';
import '../presentation/authentication/login_screen/login_screen.dart';
import '../presentation/database_screen/database_screen.dart';
import '../presentation/ddns_screen/ddns_screen.dart';
import '../presentation/documentation_screen/documentation_screen.dart';
import '../presentation/faq/faq_screen.dart';
import '../presentation/frame_one_screen/frame_one_screen.dart';
import '../presentation/help_support/help_support.dart';
import '../presentation/home_page_one_screen/home_page_one_screen.dart';
import '../presentation/home_page_two_screen/home_page_two_screen.dart';
import '../presentation/ip_address_screen/ip_address_screen.dart';
import '../presentation/notifications_screen/notifications_screen.dart';
import '../presentation/pricing_screen/pricing_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/static_screen/static_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String homePageOneScreen = '/home_page_one_screen';

  static const String homePageTwoScreen = '/home_page_two_screen';

  static const String databaseScreen = '/database_screen';

  static const String analyticsScreen = '/analytics_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String loginScreen = '/login_screen';

  static const String createAccountScreen = '/create_account_screen';

  static const String connectCctvScreen = '/connect_cctv_screen';

  static const String staticScreen = '/static_screen';

  static const String ddnsScreen = '/ddns_screen';

  static const String initialRoute = '/initialRoute';
  static const String frameOneScreen = '/frame_one_screen';

  static const String settingsScreen = '/settings_screen';

  static const String pricingScreen = '/pricing_screen';

  static const String ipAddressScreen = '/ip_address_screen';
  static const String verifyEmail = '/verifyEmail';
  static const String documentationScreen = '/documentation_screen';
  static const String faqScreen = '/faqScreen';
  static const String helpAndSupport = '/helpAndSupport';
  static const String dashboardScreen = '/dashboard_screen';
  static const String authWrapperScreen = '/authWrapper';
  static const String forgotPassword = '/forgotPassword';
  static const String splashscreen = '/splashscreen';
  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    createAccountScreen: (context) => CreateAccountScreen(),
    connectCctvScreen: (context) => ConnectCctvScreen(),
    staticScreen: (context) => StaticScreen(onStreamAdded: (url) {  },),
    ddnsScreen: (context) => DdnsScreen(),
    homePageOneScreen: (context) => HomePageOneScreen(),
    homePageTwoScreen: (context) => HomePageTwoScreen(),
    databaseScreen: (context) => DatabaseScreen(),
    analyticsScreen: (context) => AnalyticsScreen(),
    notificationsScreen: (context) => NotificationsScreen(),
    frameOneScreen: (context) => FrameOneScreen(),
    settingsScreen: (context) => SettingsScreen(),
    pricingScreen: (context) => PricingScreen(),
    ipAddressScreen: (context) => IpAddressScreen(),
    documentationScreen: (context) => DocumentationScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    dashboardScreen: (context) => DashBoardScreen(),
    splashscreen: (context) => SplashScreen(),
    // initialRoute: (context) => LoginScreen(),
    faqScreen: (context) => FAQScreen(),
    helpAndSupport: (context) => HelpAndSupportScreen(),
    authWrapperScreen: (context) => AuthWrapper(),
    forgotPassword: (context) => ForgotPasswordScreen(),
    verifyEmail: (context) => VerifyEmailScreen()
  };
}
