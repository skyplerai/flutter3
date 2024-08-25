import 'package:flutter/material.dart';
import 'package:sriram_s_application3/core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRoutes.authWrapperScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray900,
      // backgroundColor: theme.colorScheme.onBackground,
      body: Center(
        child: Image.asset("assets/images/splash_image.png"),
      ),
    );
  }
}
