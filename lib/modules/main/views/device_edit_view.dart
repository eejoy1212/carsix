import 'package:carsix/const/color.dart';
import 'package:carsix/controller/bluetooth_controller.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/bar/default_appbar.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceEditView extends StatelessWidget {
  const DeviceEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    final ThemeController themeController = Get.find<ThemeController>();
    final BLEController bleController = Get.find<BLEController>();
    return Scaffold(
      appBar: DefaultAppbar(
        title: "디바이스 수정",
        backRoute: "",
        onSave: () async {
          await bleController.saveDeviceInfo();

          Get.back(); // 수정 후 result 값을 전달하며 돌아감
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("제조사"),
              _buildTextField(
                controller: bleController.manufacturerController.value,
                hintText: "제조사를 입력해주세요.",
                cursorColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
                fillColor: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderColor: CarsixColors.grey2,
                focusedBorderColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
              ),
              const SizedBox(height: 20),
              _buildLabel("차량"),
              _buildTextField(
                controller: bleController.vehicleController.value,
                hintText: "차량을 입력해주세요.",
                cursorColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
                fillColor: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderColor: CarsixColors.grey2,
                focusedBorderColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
              ),
              const SizedBox(height: 20),
              _buildLabel("차량 번호"),
              _buildTextField(
                controller: bleController.licenseController.value,
                hintText: "차량 번호를 입력해주세요.",
                cursorColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
                fillColor: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderColor: CarsixColors.grey2,
                focusedBorderColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
              ),
              const SizedBox(height: 20),
              _buildLabel("시공점"),
              _buildTextField(
                controller: bleController.installationPlaceController.value,
                hintText: "시공점을 입력해주세요.",
                cursorColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
                fillColor: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderColor: CarsixColors.grey2,
                focusedBorderColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
              ),
              const SizedBox(height: 20),
              _buildLabel("연결제품"),
              _buildTextField(
                controller:
                    TextEditingController(text: bleController.deviceName),
                hintText: "시공점을 입력해주세요.",
                cursorColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
                fillColor: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderColor: CarsixColors.grey2,
                focusedBorderColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
              ),
              const SizedBox(height: 20),
              _buildLabel("펌웨어"),
              _buildTextField(
                readOnly: true,
                controller: TextEditingController(text: "V.10.10"),
                hintText: "",
                cursorColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
                fillColor: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderColor: CarsixColors.grey2,
                focusedBorderColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
              ),
              const SizedBox(height: 20),
              _buildLabel("하드웨어 버전"),
              _buildTextField(
                readOnly: true,
                controller: TextEditingController(text: "V.10.10"),
                hintText: "",
                cursorColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
                fillColor: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderColor: CarsixColors.grey2,
                focusedBorderColor: themeController.isDarkMode.value
                    ? CarsixColors.white1
                    : CarsixColors.black1,
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 6, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF898989),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(
      {bool readOnly = false,
      required TextEditingController controller,
      required String hintText,
      required Color fillColor,
      required Color borderColor,
      required Color focusedBorderColor,
      required Color cursorColor}) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B1B1B), Color(0xFF1B1B1B)],
          stops: [1.0, 0.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(
          color: Color(0xFF767676),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20), // 모서리 둥글기 조정
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        style: const TextStyle(
          color: Colors.white, // 텍스트 색상
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0), // 내부 여백
          border: InputBorder.none, // 기본 테두리 제거
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        cursorColor: Colors.white, // 커서 색상
      ),
    );
    TextField(
      controller: controller,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: CarsixColors.grey2.withOpacity(0.6)),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }
}
