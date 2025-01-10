import 'package:carsix/widget/bar/default_appbar.dart';
import 'package:carsix/widget/card/hidden_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class Hidden extends StatelessWidget {
  const Hidden({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppbar(
        title: "관리자 세팅 메뉴 (히든메뉴)",
        backRoute: '',
        // isComplete: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 27,
            ),
            Center(
              child: Text(
                "본 메뉴는 제품 이해도가 필요한 메뉴입니다.\n잘못된 조작시 제품의 성능에 영향을 끼칠 수 있으며,\nCarSix본사는 이에 책임을 지지 않습니다.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  HiddenCard(
                    title: '센터 좌',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HiddenCard(
                    title: '센터 우',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HiddenCard(
                    title: '1열 운전석 좌',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HiddenCard(
                    title: '1열 조수석 우',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HiddenCard(
                    title: '2열 운전석 좌',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HiddenCard(
                    title: '2열 조수석 우',
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
