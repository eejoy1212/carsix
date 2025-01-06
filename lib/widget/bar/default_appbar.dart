import 'package:carsix/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onSave;
  final String backRoute;
  final bool isComplete;
  final void Function()? initComplete;
  const DefaultAppbar(
      {super.key,
      required this.title,
      this.onSave,
      required this.backRoute,
      required this.isComplete,
      this.initComplete});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: InkWell(
          onTap: () async {
            print("isComplete>>>$isComplete");
            if (!isComplete) {
              showContinueDialog(context, backRoute);
              // if (initComplete != null) {
              //   initComplete!();
              // }
            } else {
              Get.back();
            }
          },
          child: Image.asset('assets/images/nav-arrow-left.png')),
      actions: [
        InkWell(
          onTap: onSave,
          child: Text(
            "저장하기",
            style: TextStyle(
              color: Color(0xFFE60012),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 12,
        )
      ],
      title: Text(
        title,
        style: TextStyle(
          color: CarsixColors.white1,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  void showContinueDialog(BuildContext context, String backRoute) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // 둥근 테두리
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(opacity: 0, child: Icon(Icons.close)),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close),
                    )
                  ],
                ),
                SizedBox(
                  height: 90,
                  child: Center(
                    child: Text(
                      '저장하지 않고 뒤로갑니다.\n계속 하시겠습니까?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFE7E7E8)),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // 예 버튼 눌렀을 때의 동작
                            Get.back();
                            Get.toNamed('/$backRoute');
                          },
                          child: Text(
                            "예",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF3E3E40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Color(0xFFE7E7E8)),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // 아니오 버튼 눌렀을 때의 동작
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "아니오",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // AppBar 높이 + TabBar 높이
}
