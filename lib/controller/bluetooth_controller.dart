// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class BLEController extends GetxController {
//   FlutterBlue flutterBlue = FlutterBlue.instance;
//   var isConnected = false.obs;
//   var isScanning = false.obs; // 스캔 상태 변수 추가
//   BluetoothDevice? connectedDevice;
//   String DeviceName = "CAR-SIX LED Controller";
//   @override
//   void onInit() {
//     super.onInit();
//     requestPermissions();
//     scanAndConnect();
//   }

//   void requestPermissions() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.bluetooth,
//       Permission.bluetoothScan,
//       Permission.bluetoothConnect,
//       Permission.locationWhenInUse,
//     ].request();

//     // 권한 요청 결과 출력
//     statuses.forEach((permission, status) {
//       print('$permission: $status');
//     });

//     // 필요한 권한이 모두 허용되었는지 확인
//     if (statuses[Permission.bluetoothConnect] == PermissionStatus.granted &&
//         statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
//         statuses[Permission.locationWhenInUse] == PermissionStatus.granted) {
//       print("모든 BLE 권한이 허용되었습니다.");
//     } else {
//       print("BLE 권한이 허용되지 않았습니다.");
//     }
//   }

//   void scanAndConnect() {
//     // 이미 스캔 중이면 함수 종료
//     if (isScanning.value) {
//       print("스캔이 이미 진행 중입니다.");
//       return;
//     }

//     // 스캔 시작
//     isScanning.value = true;
//     flutterBlue.startScan(timeout: Duration(seconds: 4)).catchError((e) {
//       print("BLE 스캔 오류: $e");
//     });

//     flutterBlue.scanResults.listen((results) {
//       for (ScanResult result in results) {
//         print("in for문00${result.device}");
//         if (result.device.name == DeviceName) {
//           print("in for문11${result.device}");
//           // 기기 이름 설정 필요
//           flutterBlue.stopScan();
//           isScanning.value = false; // 스캔 종료 상태로 설정
//           connectToDevice(result.device);
//           break;
//         }
//       }
//     });

//     flutterBlue.isScanning.listen((scanning) {
//       isScanning.value = scanning; // 스캔 상태 업데이트
//     });
//   }

//   void connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect();
//       isConnected.value = true;
//       connectedDevice = device;
//       print("BLE 기기와 연결되었습니다.");
//     } catch (e) {
//       print("연결 오류: $e");
//     }
//   }

//   void disconnect() {
//     connectedDevice?.disconnect();
//     isConnected.value = false;
//     print("BLE 연결이 종료되었습니다.");
//   }
// }
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BLEController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  var isConnected = false.obs;
  var isScanning = false.obs;
  BluetoothDevice? connectedDevice;
  String deviceName = "CAR-SIX LED Controller";

  // 속도 설정 변수
  RxDouble speedValue = 10.0.obs;
  BluetoothCharacteristic? characteristic; // 데이터 전송을 위한 BLE 특성

  @override
  void onInit() {
    super.onInit();
    // requestPermissions();
    // scanAndConnect();
  }

  void requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    statuses.forEach((permission, status) {
      print('$permission: $status');
    });

    if (statuses[Permission.bluetoothConnect] == PermissionStatus.granted &&
        statuses[Permission.bluetoothScan] == PermissionStatus.granted &&
        statuses[Permission.locationWhenInUse] == PermissionStatus.granted) {
      print("모든 BLE 권한이 허용되었습니다.");
    } else {
      print("BLE 권한이 허용되지 않았습니다.");
    }
  }

  void scanAndConnect() {
    if (isScanning.value) {
      print("스캔이 이미 진행 중입니다.");
      return;
    }

    isScanning.value = true;
    flutterBlue.startScan(timeout: Duration(seconds: 4)).catchError((e) {
      print("BLE 스캔 오류: $e");
    });

    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (result.device.name == deviceName) {
          flutterBlue.stopScan();
          isScanning.value = false;
          connectToDevice(result.device);
          break;
        }
      }
    });

    flutterBlue.isScanning.listen((scanning) {
      isScanning.value = scanning;
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      isConnected.value = true;
      connectedDevice = device;
      print("BLE 기기와 연결되었습니다.");

      // 연결 후에 원하는 characteristic 찾기
      discoverServices();
    } catch (e) {
      print("연결 오류: $e");
    }
  }

  void discoverServices() async {
    print("특성이 모지 $connectedDevice");
    if (connectedDevice == null) return;

    List<BluetoothService> services = await connectedDevice!.discoverServices();

    for (var service in services) {
      for (var char in service.characteristics) {
        // if (/* 특성 UUID 조건 */) {
        //   characteristic = char; // 사용할 특성 설정
        //   print("특성 발견: ${char.uuid}");
        // }
      }
    }
  }

  // 속도 설정 값을 BLE로 전송하는 함수
  void sendSpeedToBLE() {
    if (characteristic == null || !isConnected.value) {
      print("BLE에 연결되지 않았거나 특성이 설정되지 않았습니다. ${isConnected.value}");
      return;
    }

    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xC1, // CMD for speed 설정 (예시)
      0x00, // Sub CMD (예시)
      speedValue.value.toInt(), // 속도 값
      0xEB // End Byte
    ];

    characteristic!.write(command);
    print("속도 값을 BLE로 전송: $command");
  }

  // 슬라이더 값이 변경될 때 호출할 함수
  void updateSpeedValue(double value) {
    speedValue.value = value;
    sendSpeedToBLE(); // 속도 값을 전송
  }

  void disconnect() {
    connectedDevice?.disconnect();
    isConnected.value = false;
    print("BLE 연결이 종료되었습니다.");
  }
}
