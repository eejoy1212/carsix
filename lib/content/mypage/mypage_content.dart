import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageContent extends StatelessWidget {
  MyPageContent({super.key});
  final themeController = Get.find<ThemeController>();
  final bleController = Get.find<BLEController>(); // BLEController 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // 타이틀
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: [
                    Obx(
                      () => Text(
                        "마이페이지",
                        style: TextStyle(
                          height: 1.6,
                          color: themeController.isDarkMode.value
                              ? CarsixColors.white1
                              : CarsixColors.grey6,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 2,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // 다크모드 화이트모드 전환
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: const Row(
                  children: [
                    Text(
                      "테마",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                  onTap: () => themeController.toggleTheme(),
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 6,
                      left: 20,
                      right: 20,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: CarsixColors.grey2,
                    ))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(
                                () => themeController.isDarkMode.value
                                    ? Icon(Icons.dark_mode_outlined)
                                    : Icon(Icons.light_mode_outlined),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Obx(
                                () => Text(
                                  themeController.isDarkMode.value
                                      ? "화이트모드로 전환"
                                      : "다크모드로 전환",
                                  style: TextStyle(
                                    color: themeController.isDarkMode.value
                                        ? CarsixColors.white1
                                        : CarsixColors.grey6,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 1),

              // Bluetooth 연결 상태 표시
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: const Row(
                  children: [
                    Text(
                      "연결 상태",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (!bleController.isConnected.value) {
                    bleController.scanAndConnect();
                  }
                },
                child: Obx(() {
                  return Container(
                    margin:
                        const EdgeInsets.only(top: 6, left: 20.0, right: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: CarsixColors.grey2,
                    ))),
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            bleController.isConnected.value
                                ? Icons.bluetooth_connected
                                : Icons.bluetooth_disabled,
                            color: themeController.isDarkMode.value
                                ? CarsixColors.white1
                                : CarsixColors.grey6,
                          ),
                          SizedBox(width: 12),
                          Text(
                            bleController.isConnected.value
                                ? "연결됨: ${bleController.deviceName}"
                                : bleController.isScanning.value
                                    ? "연결 시도 중..."
                                    : "연결 안 됨",
                            style: TextStyle(
                              color: themeController.isDarkMode.value
                                  ? CarsixColors.white1
                                  : CarsixColors.grey6,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 1),

              // 제품 관련
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: const Row(
                  children: [
                    Text(
                      "제품 관련",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // 제품연결
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 6,
                    left: 20.0,
                    right: 20,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: CarsixColors.grey2,
                  ))),
                  child: Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Icon(
                                  Icons.bluetooth,
                                  color: themeController.isDarkMode.value
                                      ? CarsixColors.white1
                                      : CarsixColors.grey6,
                                )),
                            SizedBox(width: 12),
                            Obx(
                              () => Text(
                                "제품연결",
                                style: TextStyle(
                                  color: themeController.isDarkMode.value
                                      ? CarsixColors.white1
                                      : CarsixColors.grey6,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),

              // 카식스 업데이트
              InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: CarsixColors.grey2,
                    ))),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => Icon(
                                Icons.update_outlined,
                                color: themeController.isDarkMode.value
                                    ? CarsixColors.white1
                                    : CarsixColors.grey6,
                              )),
                          SizedBox(width: 12),
                          Obx(() => Text(
                                "카식스 업데이트",
                                style: TextStyle(
                                  color: themeController.isDarkMode.value
                                      ? CarsixColors.white1
                                      : CarsixColors.grey6,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),

              // 도움말 및 지원
              const SizedBox(height: 1),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: const Row(
                  children: [
                    Text(
                      "도움말 및 지원",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Obx(() => Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 20.0, right: 20, top: 6),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: CarsixColors.grey2,
                      ))),
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => Icon(
                                  Icons.help_outline,
                                  color: themeController.isDarkMode.value
                                      ? CarsixColors.white1
                                      : CarsixColors.grey6,
                                )),
                            const SizedBox(width: 12),
                            Text(
                              "도움말",
                              style: TextStyle(
                                color: themeController.isDarkMode.value
                                    ? CarsixColors.white1
                                    : CarsixColors.grey6,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),

              // 외부 링크 및 버전 정보
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: const Row(
                  children: [
                    Text(
                      "버전 0.0.1",
                      style: TextStyle(
                        color: CarsixColors.grey2,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
