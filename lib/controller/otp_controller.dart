import 'package:flutter/cupertino.dart';
import 'package:machine_test/controller/app_base_controller/app_base_conroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../route_management/routes.dart';


class OtpController extends AppBaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  String? otpError;

  String? verificationId;

  @override
  void onInit() {
    verificationId = Get.arguments as String?;
    super.onInit();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void verifyOTP() async {
    if (otpController.text.isEmpty) {
      otpError = 'Please enter the OTP';
      update();
      return;
    }

    otpError = null;
    isLoading = true;
    update();

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otpController.text,
      );

      await _auth.signInWithCredential(credential);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setBool('isFirstTime',true);

      Get.toNamed(homeScreen);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }

    isLoading = false;
    update();
  }
}

