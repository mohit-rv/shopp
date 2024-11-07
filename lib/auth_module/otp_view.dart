import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/Utils/colors.dart';
import 'package:machine_test/controller/otp_controller.dart';
import 'package:pinput/pinput.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;

    return GetBuilder<OtpController>(
      init: OtpController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AutoSizeText(
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const AutoSizeText(
                    'Enter the verification code sent to your phone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Pinput(
                      controller: controller.otpController,
                      length: 6,
                      validator: (s) => s == controller.otpController.text ? null : 'Pin is incorrect',
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      onCompleted: (pin) => controller.verifyOTP(),
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.black, // Set the color for the text
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 2,
                            height: 20,
                            color: AppColors.primary, // Set the cursor color
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height:50),
                  SizedBox(
                    width: widthSize / 1.2,
                    child: ElevatedButton(
                      onPressed: () => controller.verifyOTP(),
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
                        'VERIFY',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

