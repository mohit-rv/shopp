import 'package:get/get.dart';
import 'package:machine_test/controller/home_controller.dart';
import 'package:machine_test/controller/login_controller.dart';
import 'package:machine_test/controller/onboarding_first.dart';
import 'package:machine_test/controller/otp_controller.dart';
import 'package:machine_test/controller/signup_controller.dart';
import '../controller/onboarding_second_controller.dart';
import '../controller/onboarding_third_controller.dart';
import '../controller/splash_controller.dart';



class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => SplashController() );

    Get.lazyPut(() => OnBoardingFirstController() );

    Get.lazyPut(() => OnBoardingSecondController() );

    Get.lazyPut(() => OnBoardingThirdController() );

    Get.lazyPut(() => LoginController() );

    Get.lazyPut(() => OtpController());

    Get.lazyPut(() => SignUpController());

    Get.lazyPut(() => HomeController());

  }


}