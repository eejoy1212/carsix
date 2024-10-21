import 'package:carsix/modules/loading/controllers/loading_controllers.dart';
import 'package:get/get.dart';

class LoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingController>(() => LoadingController());
  }
}
