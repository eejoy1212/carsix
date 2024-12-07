import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/btn/red_btn.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabView extends StatelessWidget {
  CustomTabView({super.key});
  final MainController controller = Get.find<MainController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            //배경색
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: CarsixColors.grey2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "배경색",
                        style: TextStyle(
                          color: CarsixColors.grey2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => controller.welcomeColors.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  Get.toNamed('/bg-color');
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: themeController.isDarkMode.value
                                      ? Colors.white
                                      : CarsixColors.grey1,
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                  Obx(
                    () => controller.welcomeColors.isEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RedBtn(
                                    width: 200,
                                    color: CarsixColors.red2,
                                    onPressed: () {
                                      Get.toNamed("/bg-color");
                                    },
                                    title: Text(
                                      "컬러를 추가 해 주세요",
                                      style: TextStyle(
                                        color: CarsixColors.white1,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        : Row(
                            children: controller.welcomeColors
                                .map((color) => Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 16,
                                        ),
                                        height: 60, // 컬러 박스의 높이
                                        decoration: BoxDecoration(
                                          color: color,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          color.hex,
                                          style: TextStyle(fontSize: 16),
                                        )),
                                      ),
                                    ))
                                .toList()),
                  )
                ],
              ),
            ),

            //커스텀 모드 1
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: CarsixColors.grey2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "커스텀 모드 1",
                        style: TextStyle(
                          color: CarsixColors.grey2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => controller.welcomeColors.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  Get.toNamed('/bg-color');
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: themeController.isDarkMode.value
                                      ? Colors.white
                                      : CarsixColors.grey1,
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                  Obx(
                    () => controller.welcomeColors.isEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RedBtn(
                                    width: 200,
                                    color: CarsixColors.red2,
                                    onPressed: () {
                                      Get.toNamed("/bg-color");
                                    },
                                    title: Text(
                                      "컬러를 추가 해 주세요",
                                      style: TextStyle(
                                        color: CarsixColors.white1,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        : Row(
                            children: controller.welcomeColors
                                .map((color) => Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 16,
                                        ),
                                        height: 60, // 컬러 박스의 높이
                                        decoration: BoxDecoration(
                                          color: color,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          color.hex,
                                          style: TextStyle(fontSize: 16),
                                        )),
                                      ),
                                    ))
                                .toList()),
                  )
                ],
              ),
            ),
            //커스텀 모드 2
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: CarsixColors.grey2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "커스텀 모드 2",
                        style: TextStyle(
                          color: CarsixColors.grey2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => controller.welcomeColors.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  Get.toNamed('/bg-color');
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: themeController.isDarkMode.value
                                      ? Colors.white
                                      : CarsixColors.grey1,
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                  Obx(
                    () => controller.welcomeColors.isEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RedBtn(
                                    width: 200,
                                    color: CarsixColors.red2,
                                    onPressed: () {
                                      Get.toNamed("/bg-color");
                                    },
                                    title: Text(
                                      "컬러를 추가 해 주세요",
                                      style: TextStyle(
                                        color: CarsixColors.white1,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        : Row(
                            children: controller.welcomeColors
                                .map((color) => Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 16,
                                        ),
                                        height: 60, // 컬러 박스의 높이
                                        decoration: BoxDecoration(
                                          color: color,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          color.hex,
                                          style: TextStyle(fontSize: 16),
                                        )),
                                      ),
                                    ))
                                .toList()),
                  )
                ],
              ),
            ),
            //커스텀 모드 3
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: CarsixColors.grey2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "커스텀 모드 3",
                        style: TextStyle(
                          color: CarsixColors.grey2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(
                        () => controller.welcomeColors.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  Get.toNamed('/bg-color');
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: themeController.isDarkMode.value
                                      ? Colors.white
                                      : CarsixColors.grey1,
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                  Obx(
                    () => controller.welcomeColors.isEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RedBtn(
                                    width: 200,
                                    color: CarsixColors.red2,
                                    onPressed: () {
                                      Get.toNamed("/bg-color");
                                    },
                                    title: Text(
                                      "컬러를 추가 해 주세요",
                                      style: TextStyle(
                                        color: CarsixColors.white1,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        : Row(
                            children: controller.welcomeColors
                                .map((color) => Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 16,
                                        ),
                                        height: 60, // 컬러 박스의 높이
                                        decoration: BoxDecoration(
                                          color: color,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          color.hex,
                                          style: TextStyle(fontSize: 16),
                                        )),
                                      ),
                                    ))
                                .toList()),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: RedBtn(
                    onPressed: () {},
                    title: Text(
                      "저장",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: CarsixColors.white1,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
