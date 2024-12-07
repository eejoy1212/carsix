import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceEditView extends StatelessWidget {
  const DeviceEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("디바이스 정보 수정"),
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
                controller: controller.manufacturerController,
                hintText: "제조사를 입력하세요",
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
              const SizedBox(height: 32),
              _buildLabel("차량"),
              _buildTextField(
                controller: controller.vehicleController,
                hintText: "차량을 입력하세요",
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
              const SizedBox(height: 32),
              _buildLabel("차량 번호"),
              _buildTextField(
                controller: controller.licensePlateController,
                hintText: "차량 번호를 입력하세요",
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
              const SizedBox(height: 32),
              _buildLabel("시공점"),
              _buildTextField(
                controller: controller.installationPlaceController,
                hintText: "시공점을 입력하세요",
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
              const SizedBox(height: 32),
              RedBtn(
                width: 370,
                onPressed: () async {
                  await controller.updateDeviceInfo();
                  Get.back(result: true); // 수정 후 result 값을 전달하며 돌아감
                },
                color: CarsixColors.primaryRed,
                title: Text(
                  "수정 완료",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: CarsixColors.white1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 6, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: CarsixColors.grey2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      required Color fillColor,
      required Color borderColor,
      required Color focusedBorderColor,
      required Color cursorColor}) {
    return TextField(
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
