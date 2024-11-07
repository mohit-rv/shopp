import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/login_controller.dart';
import 'package:machine_test/route_management/routes.dart';
import 'package:machine_test/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  var code;
  LoginScreen({Key? key,this.code}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;

    return GetBuilder(
      init: LoginController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  height: heightSize/1,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height:60),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 70,
                      ),
                      const SizedBox(height: 40),
                      const Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'Login to continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        width: widthSize / 1.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: controller.phoneController,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            counterText: '',
                            hintStyle: const TextStyle(color: AppColors.greyColor),
                            prefixIcon: const Icon(Icons.phone_android, color: AppColors.greyColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.whiteColor,
                            errorText: controller.phoneError,
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: widthSize / 1.4,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.getOTP(widget.code);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: controller.isLoading
                              ? const CircularProgressIndicator(color: AppColors.whiteColor,)
                              : const Text(
                            'GET OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'Or Continue With',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _socialLoginButton(
                            asset: 'assets/images/google.png',
                            label: 'Google',
                            onTap: controller.signInWithGoogle,
                          ),

                          _socialLoginButton(
                            asset: 'assets/images/facebook.png',
                            label: 'Facebook',
                            onTap: controller.signInWithGoogle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const AutoSizeText(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(signupScreen);
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _socialLoginButton({required String asset, required String label, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Image.asset(
              asset,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


