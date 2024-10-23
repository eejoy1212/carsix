import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:get/get.dart';

class MusicColorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}
