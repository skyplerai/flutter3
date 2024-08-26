import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../services/shared_services.dart';
import '../model/stream_urls.dart';

class StreamUrlController extends GetxController {
  RxList<String> streamUrls = <String>[].obs;
  ApiService apiService = ApiService();

  @override
  void onInit() {
    loadSavedCameras();
    super.onInit();
  }

  Future<void> loadSavedCameras() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUrls = prefs.getStringList('cameras') ?? [];
    if (savedUrls.isNotEmpty) {
      streamUrls.value = savedUrls;
    } else {
      await getAllTheUrls();
    }
  }

  Future<void> saveCameras() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cameras', streamUrls);
  }

  Future<void> getAllTheUrls() async {
    try {
      final loginDetails = UserSharedServices.loginDetails();
      if (loginDetails != null && loginDetails.streamUrls != null) {
        final allUrls = loginDetails.streamUrls!;
        streamUrls.value = allUrls.cast<String>();
      } else {
        final staticUrlsResponse = await apiService.getStreamUrl("static");
        final ddnsUrlsResponse = await apiService.getStreamUrl("ddns");
        final staticUrls = (staticUrlsResponse.streamUrls ?? []).cast<String>();
        final ddnsUrls = (ddnsUrlsResponse.streamUrls ?? []).cast<String>();
        streamUrls.value = [...staticUrls, ...ddnsUrls];
      }
      await saveCameras();
      print("streamUrls: $streamUrls");
    } catch (e) {
      print("Error fetching stream URLs: $e");
    }
  }

  void addCamera(String url) {
    if (!streamUrls.contains(url)) {
      streamUrls.add(url);
      saveCameras();
    }
  }

  void removeCamera(String url) {
    streamUrls.remove(url);
    saveCameras();
  }
}