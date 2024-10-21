import 'package:get/get.dart';

class LoadingController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // 3초 후에 /device 경로로 이동
    Future.delayed(const Duration(seconds: 0), () {
      Get.toNamed('/main');
    });
  }
}
