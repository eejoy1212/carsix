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
    requestPermissions();
    scanAndConnect();
  }

// BLEController에 추가된 레인보우 모드 함수
  // void sendRainbowMode() async {
  //   if (characteristic != null && isConnected.value) {
  //     List<List<int>> rainbowCommands = [
  //       [0xEA, 0xBF, 0xCA, 0x00, 0xFF, 0x00, 0x00, 0xEB], // 빨강
  //       [0xEA, 0xBF, 0xCA, 0x00, 0xFF, 0x80, 0x00, 0xEB], // 주황
  //       [0xEA, 0xBF, 0xCA, 0x00, 0xFF, 0xFF, 0x00, 0xEB], // 노랑
  //       [0xEA, 0xBF, 0xCA, 0x00, 0x00, 0xFF, 0x00, 0xEB], // 초록
  //       [0xEA, 0xBF, 0xCA, 0x00, 0x00, 0x00, 0xFF, 0xEB], // 파랑
  //       [0xEA, 0xBF, 0xCA, 0x00, 0x4B, 0x00, 0x82, 0xEB], // 남색
  //       [0xEA, 0xBF, 0xCA, 0x00, 0x80, 0x00, 0x80, 0xEB] // 보라
  //     ];

  //     for (var command in rainbowCommands) {
  //       try {
  //         await characteristic!.write(command, withoutResponse: false);
  //         print("명령 전송 성공: $command");
  //       } catch (e) {
  //         print("명령 전송 실패: $command, 오류: $e");
  //         // 명령 전송 실패 시 추가 처리 (예: 재시도 로직)
  //       }

  //       // 전송 간 짧은 지연 추가
  //       await Future.delayed(Duration(milliseconds: 500));
  //     }
  //   } else {
  //     print(
  //         "BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
  //   }
  // }
  void sendActiveMode(int mode) async {
    // 모드 번호 유효성 검사
    if (mode < 0 || mode > 11) {
      print("유효하지 않은 모드 번호입니다: $mode");
      return;
    }

    // CMD 값 설정
    int cmd;
    if (mode == 0) {
      cmd = 0x0B; // Rainbow Mode CMD
    } else {
      cmd = 0xC5; // Active Mode CMD
    }

    // Sub CMD 설정 (레인보우 모드는 0 고정)
    int subCmd = mode == 0 ? 0x00 : mode & 0xFF;

    // 명령어 생성
    List<int> command = [
      0xEA, // Header 1
      0xBF, // Header 2
      cmd, // CMD (Active Mode 또는 Rainbow Mode)
      subCmd, // Sub CMD (모드 번호 또는 0)
      0x00, // Data 1
      0x00, // Data 2
      0x00, // Data 3
      0x00, // Data 4
      0x00, // Data 5
      0x00, // Data 6
      0x00, // Data 7
      0x00, // Data 8
      0x00, // Data 9
      0xEB // End
    ];

    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(command, withoutResponse: false);
        print(
            "${mode == 0 ? "Rainbow" : "Active"} Mode $mode 명령 전송 성공: $command");
      } catch (e) {
        print("${mode == 0 ? "Rainbow" : "Active"} Mode $mode 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  void sendActiveMode2() async {
    // Active Mode 2 명령어
    List<int> activeMode2Command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xC5, // CMD (Active Mode 변경)
      0x02, // Sub CMD (Active Mode 2)
      0x00, // Data 1
      0x00, // Data 2
      0x00, // Data 3
      0x00, // Data 4
      0x00, // Data 5
      0x00, // Data 6
      0x00, // Data 7
      0x00, // Data 8
      0x00, // Data 9
      0xEB // End
    ];

    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(activeMode2Command, withoutResponse: false);
        print("Active Mode 2 명령 전송 성공: $activeMode2Command");
      } catch (e) {
        print("Active Mode 2 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  void sendActiveMode1() async {
    // Active Mode 1 명령어
    List<int> activeMode1Command = [
      0xEA, // Header 1
      0xBF, // Header 2
      0xC5, // CMD (Active Mode 변경)
      0x01, // Sub CMD (Active Mode 1)
      0x00, // Data 1
      0x00, // Data 2
      0x00, // Data 3
      0x00, // Data 4
      0x00, // Data 5
      0x00, // Data 6
      0x00, // Data 7
      0x00, // Data 8
      0x00, // Data 9
      0xEB // End
    ];

    if (characteristic != null && isConnected.value) {
      try {
        await characteristic!.write(activeMode1Command, withoutResponse: false);
        print("Active Mode 1 명령 전송 성공: $activeMode1Command");
      } catch (e) {
        print("Active Mode 1 명령 전송 실패: $e");
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다.");
    }
  }

  Future<void> sendRainbowMode() async {
    if (characteristic != null && isConnected.value) {
      List<int> redCommand = [
        0xEA, // Header 1
        0xBF, // Header 2
        0xCA, // CMD (단색 모드 색상 변경)
        0x00, // Sub CMD (전체 대상)
        0xFF, // R (빨강 최대 값)
        0x00, // G (초록 없음)
        0x00, // B (파랑 없음)
        0x00, // Padding 1
        0x00, // Padding 2
        0x00, // Padding 3
        0x00, // Padding 4
        0x00, // Padding 5
        0x00, // Padding 6
        0xEB // End
      ];

      List<List<int>> rainbowCommands = [
        redCommand, // 빨강
        redCommand, // 주황
        redCommand, // 노랑
        redCommand, // 초록
        redCommand, // 초록
        redCommand, // 초록
        redCommand, // 초록
        redCommand, // 초록
// 보라
      ];

      for (var command in rainbowCommands) {
        try {
          // 명령 전송
          var res = await characteristic!.write(command);
          print("명령 전송 성공: $command // ${res}");

          // 충분한 지연 시간 추가 (예: 500ms)
          await Future.delayed(Duration(seconds: 1));

          // BLE 응답 읽기
          // var response = await characteristic!.read();
          // print("BLE 응답 데이터: $response");
        } catch (e) {
          print("명령 전송 실패: $command, 오류: $e");
        }
      }
    } else {
      print(
          "BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
    }
  }

  void changeAllLEDColors(int r, int g, int b) async {
    if (characteristic != null && isConnected.value) {
      // 모든 LED 스트립에 동일한 색상을 설정
      List<int> command = [
        0xEA, // Header 1
        0xBF, // Header 2
        0xCA, // CMD for single color mode
        0x00, // Sub CMD (전체 스트립 색상 설정)
        r, // Red 값 (0~255)
        g, // Green 값 (0~255)
        b, // Blue 값 (0~255)
        0xEB // End byte
      ];

      try {
        // BLE 명령 전송
        await characteristic!.write(command, withoutResponse: true);
        print("BLE 명령 전송 (LED 색상 변경): $command");
      } catch (e) {
        print("명령 전송 중 오류 발생: $e");
      }
    } else {
      print(
          "BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
    }
  }

  // 레인보우 모드를 위한 명령 전송 함수
  void sendRainbowToBLE() async {
    if (characteristic != null && isConnected.value) {
      // 레인보우 모드의 각 색상에 대한 명령어 리스트
      List<List<int>> rainbowCommands = [
        [0xEA, 0xBF, 0x01, 0x00, 0xEB], // 빨강
        [0xEA, 0xBF, 0x02, 0x00, 0xEB], // 주황
        [0xEA, 0xBF, 0x03, 0x00, 0xEB], // 노랑
        [0xEA, 0xBF, 0x04, 0x00, 0xEB], // 초록
        [0xEA, 0xBF, 0x05, 0x00, 0xEB], // 파랑
        [0xEA, 0xBF, 0x06, 0x00, 0xEB], // 남색
        [0xEA, 0xBF, 0x07, 0x00, 0xEB] // 보라
      ];

      // 각 색상 명령을 순차적으로 전송
      for (var command in rainbowCommands) {
        await characteristic!.write(command);
        print("BLE 명령 전송 (레인보우 모드): $command");

        // 전송 간 짧은 지연 추가 (1초) - 시각적으로 레인보우 효과를 주기 위함
        await Future.delayed(Duration(milliseconds: 500));
      }
    } else {
      print("BLE 연결이 설정되지 않았습니다. $characteristic // ${isConnected.value}");
    }
  }

  // LED 개수 설정 함수
  void sendLEDCountConfigToBLE(List<int> ledCounts) async {
    if (characteristic != null && isConnected.value) {
      if (ledCounts.length != 7) {
        print("LED 개수 리스트는 정확히 7개의 값을 가져야 합니다.");
        return;
      }

      List<int> command = [
        0xEA, // Header 1
        0xBF, // Header 2
        0xC1, // Command
        0x00, // Sub Command
        ...ledCounts, // Data1 ~ Data7 (각 스트립의 LED 개수)
        0x00, // Data8
        0x00, // Data9
        0xEB // End byte
      ];

      await characteristic!.write(command);
      print("BLE 명령 전송 (LED 개수 설정): $command");
    } else {
      print(
          "BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
    }
  }

  void testSetStrip1LEDCount() async {
    if (characteristic != null && isConnected.value) {
      // LED 개수 설정 명령어 생성
      //앞의 여섯자리는 숫자 채워주기 안채우면 에러날가능성있음
      List<int> command = [
        0xEA, // Header 1
        0xBF, // Header 2
        0xC1, // Command for LED count setting
        0x00, // Sub Command
        0x40, // Data1: Strip1의 LED 개수 (64개)
        0x00, // Data2: Strip2의 LED 개수 (0개)
        0x00, // Data3: Strip3의 LED 개수 (0개)
        0x00, // Data4: Strip4의 LED 개수 (0개)
        0x00, // Data5: Strip5의 LED 개수 (0개)
        0x00, // Data6: Strip6의 LED 개수 (0개)
        0x00, // Data7: (0으로 설정)
        0x00, // Data8: (0으로 설정)
        0x00, // Data9: (0으로 설정)
        0xEB // End byte
      ];

      // // 명령어 전송
      // await characteristic!.write(command);
      print(
          ">>>>>>BLE 명령 전송 (Strip1 LED 64개, 나머지 0개): $command // $characteristic");
    } else {
      print(
          ">>>>>>BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
    }
  }

  // 테스트 함수: 예시 명령어 전송
  void testSendLEDCountConfigExample1() {
    // 예시 1: EABFC1006464646464000000EB (각 스트립의 LED 개수 설정)
    List<int> ledCounts = [0x64, 0x64, 0x64, 0x64, 0x64, 0x40, 0x00];
    sendLEDCountConfigToBLE(ledCounts);
  }

  void sendTestStrip2DisableToBLE() async {
    if (characteristic != null && isConnected.value) {
      // strip2만 비활성화하고 나머지는 활성화하는 명령어
      List<int> testStripCommand = [
        0xEA, // Header 1
        0xBF, // Header 2
        0xC2, // Command
        0x01, // Enable (전체 명령 활성화)
        0x01, // Strip1 활성화
        0x01, // Strip2 비활성화
        0x01, // Strip3 활성화
        0x01, // Strip4 활성화
        0x01, // Strip5 활성화
        0x01, // Strip6 활성화
        0x01, // Strip7 활성화
        0x00, // Data8 (0으로 설정)
        0x00, // Data9 (0으로 설정)
        0xEB // End byte
      ];

      try {
        // 명령어 전송 (with response) 및 지연 추가
        await characteristic!.write(testStripCommand, withoutResponse: false);
        print("BLE 명령 전송 (strip2 비활성화): $testStripCommand");

        // 전송 후 짧은 지연
        await Future.delayed(Duration(milliseconds: 500));
      } catch (e) {
        print("명령 전송 중 오류 발생: $e");
      }
    } else {
      print(
          "BLE 연결이 설정되지 않았습니다. characteristic: $characteristic, isConnected: ${isConnected.value}");
    }
  }

  void sendActiveModeToBLE(int command) {
    if (characteristic != null && isConnected.value) {
      List<int> protocolCommand = [
        0xEA, // Header
        0xBF, // Header 2
        command, // Command
        0x00, // Sub Command
        0xEB // End byte
      ];
      characteristic!.write(protocolCommand);
      print("BLE 명령 전송 in sendCommandToBLE : $protocolCommand");
    } else {
      print("BLE 연결이 설정되지 않았습니다.$characteristic // ${isConnected.value}");
    }
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
      print("연결결과00--->>>$results");
      for (ScanResult result in results) {
        if (result.advertisementData.localName == deviceName) {
          flutterBlue.stopScan();
          isScanning.value = false;
          print("연결결과11--->>>$result");
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
      print("BLE 기기와 연결되었습니다.$connectedDevice");

      // 연결 후에 원하는 characteristic 찾기
      discoverServices();
    } catch (e) {
      print("연결 오류: $e");
    }
  }

  void discoverServices() async {
    if (connectedDevice == null) return;

    List<BluetoothService> services = await connectedDevice!.discoverServices();
    print("발견된 서비스 목록: $services");

    for (var service in services) {
      print("서비스 확인 중: ${service.uuid}");

      for (var char in service.characteristics) {
        // RX Characteristic UUID로 설정
        if (char.uuid.toString() == "6e400002-b5a3-f393-e0a9-e50e24dcca9e") {
          characteristic = char;
          print("필요한 characteristic 발견: ${char.uuid}");
          print("  >>>>>>>>>>속성: ${char.uuid} // ${char.properties}");
          break;
        }
      }

      if (characteristic != null) break; // 원하는 characteristic을 찾았으므로 루프 종료
    }

    if (characteristic == null) {
      print("필요한 characteristic을 찾지 못했습니다.");
    } else {
      print("BLE characteristic이 설정되었습니다.");
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
