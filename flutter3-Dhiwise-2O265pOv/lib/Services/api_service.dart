//lib/services/api_service.dart
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../model/face_data.dart';
import '../model/stream_urls.dart';
import '../model/camera_user_detected.dart';
import '../services/shared_services.dart';
import '../routes/app_routes.dart';
import '../constants/snack_bar.dart';

class ApiService {
  static const _baseUrl = 'http://13.200.111.211';

  Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    log(response.request!.url.toString());
    log(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle login success
    } else {
      debugPrint('Login failed: ${response.statusCode} ${response.body}');
    }
    return response;
  }

  Future<http.Response> register(BuildContext context,
      {String? email, String? password, String? userName}) async {
    var response;
    if (email!.isEmpty || password!.isEmpty || userName!.isEmpty) {
      showSnackBar("Please fill up all the fields.", context);
    } else {
      response = await http.post(
        Uri.parse('$_baseUrl/auth/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': email, 'password': password, 'username': userName}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint(
            'Registration success: ${response.statusCode} ${response.body}');
        showSnackBar(data['detail'], context);
        Navigator.pushNamed(context, AppRoutes.verifyEmail);
      } else {
        final data = jsonDecode(response.body);
        debugPrint(
            'Registration failed: ${response.statusCode} ${response.body}');
        if (data['password'] != null) {
          showSnackBar(data['password'][0], context);
        }
        if (data['error'] != null) {
          showSnackBar(data['error'][0], context);
        }
        if (data['email'] != null) {
          showSnackBar(data['email'][0], context);
        }
        if (data['username'] != null) {
          showSnackBar(data['username'][0], context);
        }
      }
    }
    return response;
  }

  Future<http.Response> logout() async {
    final token = UserSharedServices.loginDetails()!.accessToken;
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/logout/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token}',
      },
      body: jsonEncode({"refresh": "string"}),
    );
    if (response.statusCode == 200) {
      await UserSharedServices.logout();
      final data = jsonDecode(response.body);
      debugPrint('Logout successful: $data');
    } else {
      debugPrint('Logout failed: ${response.statusCode} ${response.body}');
    }
    return response;
  }

  Future<http.Response> addStaticCamera({
    String? ipAddress,
    String? username,
    String? password,
  }) async {
    final token = UserSharedServices.loginDetails()?.accessToken;
    if (token == null) {
      throw Exception("Access token is null");
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/camera/static-camera/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'ip_address': ipAddress,
        'username': username,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> addDDNSCamera({
    String? ipAddress,
    String? username,
    String? password,
  }) async {
    final token = UserSharedServices.loginDetails()?.accessToken;
    if (token == null) {
      throw Exception("Access token is null");
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/camera/ddns-camera/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'ddns_hostname': ipAddress,
        'username': username,
        'password': password,
      }),
    );
    return response;
  }

  Future<StreamUrls> getStreamUrl(String cameraType) async {
    final token = UserSharedServices.loginDetails()?.accessToken;
    if (token == null) {
      throw Exception("Access token is null");
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/camera/get-stream-url/$cameraType/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return StreamUrls.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load stream URLs: ${response.body}");
    }
  }
  static Future<void> emailVerify(BuildContext context, {String? otp}) async {
    if (otp!.isEmpty || otp.length < 6) {
      showSnackBar("Please enter otp to continue", context);
    } else {
      final response = await http.post(
          Uri.parse('$_baseUrl/auth/verify-email/'),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({"code": "$otp"}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showSnackBar("${data["detail"]}", context);
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
      } else {
        final data = jsonDecode(response.body);
        print("Error: $data");
        if (data["error"] != null) {
          showSnackBar("${data["error"][0]}", context);
        }
      }
    }
  }

  Future<bool> sendOtpToEmail(BuildContext context, {String? email}) async {
    var headers = {'Content-Type': 'application/json'};
    bool returnValue = false;
    final response = await http.post(
        Uri.parse('$_baseUrl/auth/request-reset-password/'),
        body: jsonEncode({"email": email}),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['success'] != null) {
        showSnackBar(data['success'], context);
      }
      returnValue = true;
    } else {
      final data = jsonDecode(response.body);
      if (data['error'] != null) {
        showSnackBar(data['error'], context);
      } else {
        showSnackBar("Something went wrong.", context);
      }
    }
    return returnValue;
  }

  Future<http.Response> createNewPassword(BuildContext context,
      {String? otp,
        String? password,
        String? email,
        String? confirmPassword}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/set-new-password/'),
      body: jsonEncode({
        "email": email,
        "otp": otp,
        "new_password": password,
        "confirm_password": confirmPassword
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      Navigator.pushNamed(context, AppRoutes.loginScreen);
      showSnackBar(data['success'], context);
    } else {
      showSnackBar("Something went wrong.", context);
    }
    return response;
  }

  Future<CameraDetectedUsers> getDetectedFaces({
    String? date,
    String? month,
    String? year,
  }) async {
    final token = UserSharedServices.loginDetails()!.accessToken;
    String queryString = '';
    if (date != null && month != null && year != null) {
      // Correctly format the date as YYYY-MM-DD
      queryString = '?date=$year-$month-$date';
    } else if (month != null && year != null) {
      queryString = '?month=$month&year=$year';
    } else if (year != null) {
      queryString = '?year=$year';
    }
    final response = await http.get(
      Uri.parse('$_baseUrl/camera/faces/$queryString'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return cameraDetectedUsersFromJson(response.body);
    } else {
      throw Exception('Failed to load detected faces');
    }
  }


  Future<http.Response> signInWithGoogle(String token) async {
    final url = Uri.parse('$_baseUrl/auth/google-sign-in/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to sign in with Google');
    }
  }

  Future<bool> renameFace(int faceId, String newName) async {
    final token = UserSharedServices.loginDetails()!.accessToken;
    final response = await http.patch(
      Uri.parse('$_baseUrl/camera/rename-face/$faceId/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': newName}),
    );
    return response.statusCode == 200;
  }

  Future<bool> renameCamera(String cameraType, int cameraId, String newName) async {
    final token = UserSharedServices.loginDetails()!.accessToken;
    final response = await http.patch(
      Uri.parse('$_baseUrl/camera/rename-camera/$cameraType/$cameraId/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': newName}),
    );
    return response.statusCode == 200;
  }

  Future<FaceData> getFaceAnalytics() async {
    final token = UserSharedServices.loginDetails()?.accessToken;
    if (token == null) {
      throw Exception("Access token is null");
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/camera/face-analytics/'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return FaceData.fromJson(json.decode(response.body));
      } else {
        final errorResponse = json.decode(response.body);
        log('Error: ${errorResponse['detail'] ?? 'Unknown error'}');
        throw Exception('Failed to load face analytics data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching face analytics data: $e');
      throw Exception('Failed to load face analytics data');
    }
  }

}

