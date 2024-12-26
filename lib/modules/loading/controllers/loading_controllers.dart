import 'dart:io';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  void checkPlatform() {
    if (Platform.isAndroid) {
      print("이 기기는 Android입니다.");
      Get.toNamed('/aos-info');
    } else if (Platform.isIOS) {
      print("이 기기는 iOS입니다.");
      Get.toNamed('/ios-info');
    } else {
      print("이 기기는 Android 또는 iOS가 아닙니다.");
    }
  }

  @override
  void onInit() {
    super.onInit();

    // 3초 후에 /device 경로로 이동
    Future.delayed(const Duration(seconds: 2), () {
      // Get.toNamed('/main');
      // Get.toNamed('/aos-info');
      checkPlatform();
    });
  }
}
