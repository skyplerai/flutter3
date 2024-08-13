// lib/providers/camera_provider.dart

import 'package:flutter/material.dart';

import '../services/api_service.dart';

class CameraProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

// Future<void> addStaticCamera(StaticCamera camera) async {
//   await _apiService.addStaticCamera({
//     'ip_address': camera.ipAddress,
//     'username': camera.username,
//     'password': camera.password,
//   });
//   notifyListeners();
// }
//
// Future<void> addDDNSCamera(DDNSCamera camera) async {
//   await _apiService.addDDNSCamera({
//     'ddns_hostname': camera.ddnsHostname,
//     'username': camera.username,
//     'password': camera.password,
//   });
//   notifyListeners();
// }
//
// Future<String?> getStreamUrl(String cameraType) async {
//   return await _apiService.getStreamUrl(cameraType);
// }
}
