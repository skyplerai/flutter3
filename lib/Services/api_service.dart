import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:sriram_s_application3/Services/shared_services.dart';
import 'package:sriram_s_application3/constants/snack_bar.dart';
import 'package:sriram_s_application3/model/stream_urls.dart';

import '../model/camera_user_detected.dart';
import '../routes/app_routes.dart';
import '../widgets/video_player/video_player.dart';

// All API calls are in this screen

class ApiService {
  static const _baseUrl = 'http://52.202.36.66';

  // this is base url - whenever there is change of url just change this url

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
    } else {
      debugPrint('Login failed: ${response.statusCode} ${response.body}');
    }
    return response;
  }

  Future<http.Response> register(context,
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
        debugPrint('Login succes: ${response.statusCode} ${response.body}');
        showSnackBar(data['detail'], context);
        Navigator.pushNamed(context, AppRoutes.verifyEmail);
      } else {
        final data = jsonDecode(response.body);
        debugPrint('Login failed: ${response.statusCode} ${response.body}');
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
      debugPrint('logout successful: $data');
    } else {
      debugPrint('logout failed: ${response.statusCode} ${response.body}');
    }
    return response;
  }

  Future<http.Response> addStaticCamera(
      {String? ipAddress, String? username, String? password}) async {
    final token = UserSharedServices.loginDetails()!.accessToken;
    final response = await http.post(
      Uri.parse('$_baseUrl/camera/static-camera/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'ip_address': ipAddress,
        'username': username,
        'password': password
      }),
    );
    return response;
  }

  Future<http.Response> addDDNSCamera(
      {String? ipAddress, String? username, String? password}) async {
    final token = UserSharedServices.loginDetails()!.accessToken;
    final response = await http.post(
      Uri.parse('$_baseUrl/camera/ddns-camera/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'ddns_hostname': ipAddress,
        'username': username,
        'password': password
      }),
    );
    return response;
  }

  Future<StreamUrls> getStreamUrl(String cameraType) async {
    final token = UserSharedServices.loginDetails()!.accessToken;
    StreamUrls streamUrls = StreamUrls();
    final response = await http.get(
      Uri.parse('$_baseUrl/camera/get-stream-url/$cameraType/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      streamUrls = streamUrlsFromJson(response.body);
    }
    return streamUrls;
  }

  static emailVerify(context, {String? otp}) async {
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
        print("object $data");
        if (data["error"] != null) {
          showSnackBar("${data["error"][0]}", context);
        }
      }
    }
  }

  Future<bool> sendOtpToEmail(context, {String? email}) async {
    var headers = {'Content-Type': 'application/json'};
    bool returnValue = false;
    final response = await http.post(
        Uri.parse('$_baseUrl/auth/request-reset-password/'),
        body: jsonEncode({"email": email}),
        headers: headers);
    print("response.statusCode ${response.statusCode}");
    print("object ${response.body.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print("object $data");
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

  Future<http.Response> createNewPassword(context,
      {String? otp,
      String? password,
      String? email,
      String? confirmPassword}) async {
    final response =
        await http.post(Uri.parse('$_baseUrl/auth/set-new-password/'),
            body: jsonEncode({
              "email": email,
              "otp": otp,
              "new_password": password,
              "confirm_password": confirmPassword
            }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      Navigator.pushNamed(context, AppRoutes.loginScreen);
      showSnackBar(data['success'], context);
    } else {
      showSnackBar("Something went wrong.", context);
    }
    return response;
  }

  Future<http.Response> sendFaces({String? name, String? embedding}) async {
    final token = UserSharedServices.loginDetails()!.accessToken;
    final response = await http.post(
      Uri.parse('$_baseUrl/camera/faces/'),
      body: jsonEncode({
        "name": name,
        "embedding": embedding,
      }),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("response ${response.statusCode} ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print("object $data");
    } else {
      final data = jsonDecode(response.body);
      print("object $data");
    }
    return response;
  }

  Future<void> sendDetectedFacesToBackend(List<DetectedFace> faces) async {
    for (var face in faces) {
      try {
        final response = await http.post(
          Uri.parse('$_baseUrl/camera/face/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'name': face.name,
            'embedding': face.embedding,
            'image': face.image,
          }),
        );

        if (response.statusCode == 201) {
          print('Face saved successfully');
        } else {
          print('Failed to save face: ${response.body}');
        }
      } catch (e) {
        print('Error sending face data: $e');
      }
    }
  }

  Future<http.Response> sendFacesUsingMultipart(
      {String? name, Uint8List? image}) async {
    final token = UserSharedServices.loginDetails()!.accessToken;

    var request =
        http.MultipartRequest('POST', Uri.parse('$_baseUrl/camera/faces/'))
          ..headers['Authorization'] = 'Bearer $token'
          ..headers['Content-Type'] = 'multipart/form-data';

    request.fields['name'] = name ?? '';
    request.files.add(
      http.MultipartFile.fromBytes(
        'embedding',
        image!,
        filename: 'image.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print("response status: ${response.statusCode}");
    print("response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        final data = jsonDecode(response.body);
        print("object $data");
      } catch (e) {
        print("Error decoding response: $e");
      }
    } else {
      try {
        final data = jsonDecode(response.body);
        print("Error response $data");
      } catch (e) {
        print("Error decoding error response: $e");
      }
    }

    return response;
  }

  Future<CameraDetectedUsers> getCameraFaces() async {
    CameraDetectedUsers detectedUsers = CameraDetectedUsers();
    final token = UserSharedServices.loginDetails()!.accessToken;
    final response = await http.get(
      Uri.parse('$_baseUrl/camera/detected-faces/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['stream_url'];
    }
    return detectedUsers;
  }

  Future<http.Response> signInWithGoogle(String token) async {
    final url = Uri.parse('$_baseUrl/auth/google-sign-in/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign in with Google');
    }
  }
}
