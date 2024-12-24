import 'package:carsix/const/color.dart';
import 'package:carsix/modules/loading/controllers/loading_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoadingView extends StatelessWidget {
  LoadingView({super.key});
  final LoadingController controller = Get.find<LoadingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              margin: EdgeInsets.only(
                  // left: 115,
                  // right: 115,
                  ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Opacity(
                        opacity: 0,
                        child: SvgPicture.asset('assets/images/glow-logo.svg')),
                    Image.asset(
                      'assets/images/logo_splash.png',
                      // colorFilter: ColorFilter.mode(
                      //   CarsixColors.primaryRed,
                      //   // BlendMode.color,
                      // ),
                    ),
                    SizedBox(
                      width: 250,
                      child: SvgPicture.asset(
                        'assets/images/glow-logo.svg',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ])),
        ),
      ),
    );
  }
}
