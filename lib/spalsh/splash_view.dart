import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:SplashController(),
      builder: (controller) {
      return Scaffold(
        body:Center(child: Image.asset('assets/images/logo.png',height: 150,width: 150,)),
      );
    },);
  }
}
