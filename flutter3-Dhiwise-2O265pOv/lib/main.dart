import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Services/provider.dart';
import 'constants/snack_bar.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');
  runApp(ChangeNotifierProvider(
    create: (context) => CameraProvider(),
    child: MyApp(),
  ));
  FlutterNativeSplash.remove();
  preferences = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        theme: theme,
        color: Colors.orange,
        title: 'sriram_s_application3',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashscreen,
        routes: AppRoutes.routes,
      );
    });
  }
}
