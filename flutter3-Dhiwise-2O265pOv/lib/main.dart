import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sriram_s_application3/widgets/video_player/video_player.dart';

import 'Services/provider.dart';
import 'constants/snack_bar.dart';
import 'constants/stream_urls.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(StreamUrlController());
  Get.put(WebSocketController());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');
  runApp(ChangeNotifierProvider(
    create: (context) => CameraProvider(),
    child: MyApp(),
  ));
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
