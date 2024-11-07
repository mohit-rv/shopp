import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/app_base_controller/app_base_conroller.dart';
import 'package:machine_test/route_management/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashController extends AppBaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    checkUserAuthentication();
  }

  void checkUserAuthentication() async {
    User? user = _auth.currentUser;
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isFirstTime = sp.getBool('isFirstTime') ?? false;

    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Get.offNamed(homeScreen);
      });
    } else {
      if (isFirstTime == false) {
        Timer(const Duration(seconds: 3), () {
          Get.offNamed(onBoardingFirstScreen);
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          Get.offNamed(loginScreen);
        });
      }
    }
  }

}
