
import 'package:get/get.dart';
import 'package:machine_test/auth_module/login_view.dart';
import 'package:machine_test/auth_module/otp_view.dart';
import 'package:machine_test/auth_module/signup_view.dart';
import 'package:machine_test/route_management/routes.dart';
import 'package:machine_test/route_management/screen_bindings.dart';
import 'package:machine_test/views/onboarding_views/onboarding_first.dart';
import 'package:machine_test/views/onboarding_views/onboarding_third_view.dart';
import 'package:machine_test/views/onboarding_views/onboarding_view_second.dart';
import '../spalsh/splash_view.dart';
import '../views/home_view.dart';

class AllPages {
  static List<GetPage> getPages() {

    return [
      GetPage(
          name: splashScreen,
          page: () => const SplashScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:onBoardingFirstScreen,
          page: () => const OnBoardingViewFirst(),
          binding: ScreenBindings()),

      GetPage(
          name:onBoarding2Screen,
          page: () => const OnBoardingViewSecond(),
          binding: ScreenBindings()),


      GetPage(
          name:onBoarding3Screen,
          page: () => const OnBoardingThirdView(),
          binding: ScreenBindings()),

      GetPage(
          name:loginScreen,
          page: () => LoginScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:otpScreen,
          page: () => const OtpScreen(),
          binding: ScreenBindings()),

      GetPage(
          name:signupScreen,
          page: () => const SignUpScreen(),
          binding: ScreenBindings()),


      GetPage(
          name:homeScreen,
          page: () => const HomeScreen(),
          binding: ScreenBindings()),



    ];
  }
}
