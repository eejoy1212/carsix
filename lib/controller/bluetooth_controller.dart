import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BLEController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  var isConnected = false.obs;
  var isScanning = false.obs; // 스캔 상태 변수 추가
  BluetoothDevice? connectedDevice;
  String DeviceName = "CAR-SIX LED Controller";
  @override
  void onInit() {
    super.onInit();
    requestPermissions();
    scanAndConnect();
  }

  void requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
  }

  void scanAndConnect() {
    // 이미 스캔 중이면 함수 종료
    if (isScanning.value) {
      print("스캔이 이미 진행 중입니다.");
      return;
    }

    // 스캔 시작
    isScanning.value = true;
    flutterBlue.startScan(timeout: Duration(seconds: 4)).catchError((e) {
      print("BLE 스캔 오류: $e");
    });

    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        print("in for문00${result.device.name}");
        if (result.device.name == DeviceName) {
          print("in for문11");
          // 기기 이름 설정 필요
          flutterBlue.stopScan();
          isScanning.value = false; // 스캔 종료 상태로 설정
          connectToDevice(result.device);
          break;
        }
      }
    });

    flutterBlue.isScanning.listen((scanning) {
      isScanning.value = scanning; // 스캔 상태 업데이트
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      isConnected.value = true;
      connectedDevice = device;
      print("BLE 기기와 연결되었습니다.");
    } catch (e) {
      print("연결 오류: $e");
    }
  }

  void disconnect() {
    connectedDevice?.disconnect();
    isConnected.value = false;
    print("BLE 연결이 종료되었습니다.");
  }
}
