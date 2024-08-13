import 'dart:convert';

import 'package:sriram_s_application3/model/user_login_model.dart';

import '../constants/snack_bar.dart';

// these are local variables saved locally in user device on logged in

class UserSharedServices {
  static Future<void> setLoginDetails(UserLoginModel? responseModel) async {
    if (responseModel != null) {
      preferences!
          .setString("login_details", jsonEncode(responseModel.toJson()));
    }
  }

  static UserLoginModel? loginDetails() {
    if (preferences!.getString("login_details") != null) {
      return UserLoginModel.fromJson(
          jsonDecode(preferences!.getString("login_details")!));
    } else {
      return null;
    }
  }

  static Future<bool> logout() async {
    await preferences!.clear();
    preferences?.remove('login_details');
    return true;
  }

  static bool isLoggedIn() {
    return preferences!.getString("login_details") != null ? true : false;
  }
}
