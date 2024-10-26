import 'package:carsix/const/color.dart';
import 'package:carsix/theme/controllers/theme_controller.dart';
import 'package:carsix/widget/card/device_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyPageContent extends StatelessWidget {
  MyPageContent({super.key});
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            //타이틀
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

            //다크모드 화이트모드 전환
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
              child: Obx(() => Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: themeController.isDarkMode.value
                          ? CarsixColors.grey1
                          : CarsixColors.white2,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20, top: 16, bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
            ),
            const SizedBox(
              height: 1,
            ),
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
            //제품연결
            InkWell(
              onTap: () {},
              child: Obx(() => Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: double.infinity,
                    color: themeController.isDarkMode.value
                        ? CarsixColors.grey1
                        : CarsixColors.white2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20, top: 16, bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "제품연결", // 받아온 컨텐츠를 표시
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
                        ],
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 1,
            ),
            //카식스 업데이트
            InkWell(
              onTap: () {},
              child: Obx(() => Container(
                    width: double.infinity,
                    color: themeController.isDarkMode.value
                        ? CarsixColors.grey1
                        : CarsixColors.white2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20, top: 16, bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "카식스 업데이트", // 받아온 컨텐츠를 표시
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
                        ],
                      ),
                    ),
                  )),
            ),
            //도움말

            const SizedBox(
              height: 1,
            ),
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
                    margin: const EdgeInsets.only(top: 6),
                    width: double.infinity,
                    color: themeController.isDarkMode.value
                        ? CarsixColors.grey1
                        : CarsixColors.white2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20, top: 16, bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "도움말", // 받아온 컨텐츠를 표시
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
                        ],
                      ),
                    ),
                  )),
            ),
            //홈페이지

            const SizedBox(
              height: 1,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: const Row(
                children: [
                  Text(
                    "외부 링크",
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
                    margin: EdgeInsets.only(top: 6),
                    width: double.infinity,
                    color: themeController.isDarkMode.value
                        ? CarsixColors.grey1
                        : CarsixColors.white2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20, top: 16, bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "홈페이지", // 받아온 컨텐츠를 표시
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
                        ],
                      ),
                    ),
                  )),
            ),
            //인스타그램 자랑하기
            // const SizedBox(
            //   height: 1,
            // ),
            // InkWell(
            //     onTap: () {},
            //     child: Container(
            //       width: double.infinity,
            //       color: themeController.isDarkMode.value
            //           ? CarsixColors.grey1
            //           : CarsixColors.white2,
            //       child: Padding(
            //         padding: EdgeInsets.only(
            //             left: 20.0, right: 20, top: 16, bottom: 16),
            //         child: Column(
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   "인스타그램 자랑하기", // 받아온 컨텐츠를 표시
            //                   style: TextStyle(
            //                     color: themeController.isDarkMode.value
            //                         ? CarsixColors.white1
            //                         : CarsixColors.grey6,
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     )),
          ],
        ),
      ),
    );
  }
}
