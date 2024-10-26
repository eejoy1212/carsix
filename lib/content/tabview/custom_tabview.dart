import 'package:carsix/const/color.dart';
import 'package:carsix/modules/main/controllers/main_controller.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabView extends StatelessWidget {
  CustomTabView({super.key});
  final MainController controller = Get.put(MainController());
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
                color: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                    spreadRadius: 2, // 그림자가 퍼지는 정도
                    blurRadius: 5, // 그림자의 흐림 정도
                    offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                  ),
                ],
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
                      IconButton(
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
                    ],
                  ),
                  Obx(
                    () => controller.welcomeColors.isEmpty
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("컬러를 추가 해 주세요"),
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
                color: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                    spreadRadius: 2, // 그림자가 퍼지는 정도
                    blurRadius: 5, // 그림자의 흐림 정도
                    offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                  ),
                ],
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
                      IconButton(
                        onPressed: () {
                          Get.toNamed('/custom1');
                        },
                        icon: Icon(
                          Icons.edit,
                          color: themeController.isDarkMode.value
                              ? Colors.white
                              : CarsixColors.grey1,
                        ),
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
                                Text("컬러를 추가 해 주세요"),
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
                color: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                    spreadRadius: 2, // 그림자가 퍼지는 정도
                    blurRadius: 5, // 그림자의 흐림 정도
                    offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                  ),
                ],
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
                      IconButton(
                        onPressed: () {
                          Get.toNamed('/custom2');
                        },
                        icon: Icon(
                          Icons.edit,
                          color: themeController.isDarkMode.value
                              ? Colors.white
                              : CarsixColors.grey1,
                        ),
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
                                Text("컬러를 추가 해 주세요"),
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
                color: themeController.isDarkMode.value
                    ? CarsixColors.grey1
                    : CarsixColors.white2,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // 그림자 색상 (조정 가능)
                    spreadRadius: 2, // 그림자가 퍼지는 정도
                    blurRadius: 5, // 그림자의 흐림 정도
                    offset: Offset(0, 6), // 그림자의 위치 (x축, y축)
                  ),
                ],
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
                      IconButton(
                        onPressed: () {
                          Get.toNamed('/custom3');
                        },
                        icon: Icon(
                          Icons.edit,
                          color: themeController.isDarkMode.value
                              ? Colors.white
                              : CarsixColors.grey1,
                        ),
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
                                Text("컬러를 추가 해 주세요"),
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
          ],
        ),
      ),
    );
  }
}
