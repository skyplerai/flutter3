import 'package:get/get.dart';

import '../Services/api_service.dart';
import '../Services/shared_services.dart';

class StreamUrlController extends GetxController {
  @override
  void onInit() {
    getAllTheUrls();
    super.onInit();
  }

  getAllTheUrls() async {
    if (UserSharedServices.loginDetails()!.streamUrls!.isNotEmpty &&
        UserSharedServices.loginDetails()!.streamUrls != null) {
      final existingStreamUrlsSet = streamUrls.toSet();
      final allUrlSet = UserSharedServices.loginDetails()!.streamUrls!.toSet();
      streamUrls.addAll(allUrlSet.difference(existingStreamUrlsSet));
      print("streamUrls ${streamUrls} ");
    } else {
      final staticUrlss = await apiService.getStreamUrl("static");
      final ddnsUrlss = await apiService.getStreamUrl("ddns");
      final staticUrlsSet = staticUrlss.streamUrls!.toSet();
      final ddnsUrlsSet = ddnsUrlss.streamUrls!.toSet();
      final existingStreamUrlsSet = streamUrls.toSet();
      streamUrls.addAll(staticUrlsSet.difference(existingStreamUrlsSet));
      streamUrls.addAll(ddnsUrlsSet.difference(existingStreamUrlsSet));
      print("streamUrls ${streamUrls} ");
    }
  }

  RxList streamUrls = [].obs;
  ApiService apiService = ApiService();
}
