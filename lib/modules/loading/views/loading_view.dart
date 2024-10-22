import 'package:carsix/modules/loading/controllers/loading_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingView extends StatelessWidget {
  LoadingView({super.key});
  final LoadingController controller = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            margin: EdgeInsets.only(left: 26, right: 26),
            child: Image.asset('assets/images/logo.png')),
      ),
    );
  }
}
