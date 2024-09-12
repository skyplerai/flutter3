import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/shared_services.dart';
import '../model/stream_urls.dart';
import '../widgets/video_player/video_player.dart';

class StreamUrlController extends GetxController {
  RxList<String> streamUrls = <String>[].obs;
  ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    loadAndConnectStreams();
  }

  Future<void> loadAndConnectStreams() async {
    await getAllTheUrls();
    connectToAllStreams();
  }

  Future<void> getAllTheUrls() async {
    try {
      final savedUrls = await UserSharedServices.getStreamUrls();
      if(savedUrls.isNotEmpty){
        streamUrls.assignAll(savedUrls);
      } else {
        final staticUrlsResponse = await apiService.getStreamUrl("static");
        final ddnsUrlsResponse = await apiService.getStreamUrl("ddns");
        final staticUrls = (staticUrlsResponse.streamUrls ?? []).cast<String>();
        final ddnsUrls = (ddnsUrlsResponse.streamUrls ?? []).cast<String>();
        streamUrls.addAll(staticUrls);
        streamUrls.addAll(ddnsUrls);
      }
      print("streamUrls: $streamUrls");
      // Save the updated streamUrls to shared preferences
      await UserSharedServices.saveStreamUrls(streamUrls);
    } catch (e) {
      print("Error fetching stream URLs: $e");
    }
  }

  void connectToAllStreams() {
    for (var url in streamUrls) {
      connectToStream(url);
    }
  }

  void connectToStream(String url) {
    Get.to(() => WebSocketVideoPlayer(webSocketUrl: url, authToken: 'your_auth_token'));
  }

  Future<void> addNewStream(String url) async {
    if (!streamUrls.contains(url)) {
      streamUrls.add(url);
      await UserSharedServices.saveStreamUrls(streamUrls);
      connectToStream(url);
    }
  }
}