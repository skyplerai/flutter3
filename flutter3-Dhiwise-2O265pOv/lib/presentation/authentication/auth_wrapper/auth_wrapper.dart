import 'package:flutter/material.dart';
import 'package:sriram_s_application3/Services/shared_services.dart';

import '../../../routes/app_routes.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper();

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (UserSharedServices.loginDetails() != null) {
          Navigator.pushNamed(context, AppRoutes.dashboardScreen);
        } else {
          Navigator.pushNamed(context, AppRoutes.loginScreen);
        }
      },
    );
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      ),
    );
  }
}
