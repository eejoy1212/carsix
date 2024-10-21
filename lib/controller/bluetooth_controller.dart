import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  final RxList<DiscoveredDevice> discoveredDevices =
      <DiscoveredDevice>[].obs; // 스캔한 장치 목록
  final RxBool isScanning = false.obs; // 스캔 상태
  late StreamSubscription<DiscoveredDevice> _scanSubscription; // 스캔 구독

  @override
  void onInit() {
    super.onInit();
    requestPermissions(); // 권한 요청
  }

  // BLE 스캔 시작
  void startScan() {
    print('스캔중>>> $isScanning');
    if (isScanning.value) return; // 이미 스캔 중이면 종료
    isScanning.value = true;
    discoveredDevices.clear();

    _scanSubscription = _ble.scanForDevices(withServices: []).listen((device) {
      print('새로운 블루투스 장치>>> $discoveredDevices');
      if (!discoveredDevices.any((d) => d.id == device.id)) {
        discoveredDevices.add(device); // 새로운 장치 추가
      }
    });

    Future.delayed(Duration(seconds: 10), () {
      // 10초 후 스캔 중지
      stopScan();
    });
  }

  // 스캔 중지
  void stopScan() {
    _scanSubscription.cancel(); // 스캔 스트림 구독 취소
    isScanning.value = false;
  }

  // 권한 요청 함수 추가
  Future<void> requestPermissions() async {
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }
}
