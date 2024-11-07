import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../Utils/colors.dart';
import '../controller/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 80.0), // Added top padding
                    const AutoSizeText(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const AutoSizeText(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    buildNameInput(controller,widthSize),
                    const SizedBox(height:15.0),
                    buildEmailInput(controller, widthSize),
                    const SizedBox(height:15.0),
                    buildPasswordInput(controller),
                    const SizedBox(height: 16.0),
                    buildConfirmPasswordInput(controller),
                    const SizedBox(height:15.0),
                    buildPhoneNumberInput(controller),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: controller.validateForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                    const SizedBox(height:30.0),
                    const AutoSizeText(
                      'Or Continue With',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30.0),
                    buildSocialMediaButtons(),
                    const SizedBox(height:10.0), // Added bottom padding
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildNameInput(SignUpController controller, double widthSize) {
    return Container(
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
        controller: controller.nameController,
        decoration: InputDecoration(
          labelText: 'Full Name',
          hintStyle: const TextStyle(color: AppColors.greyColor),
          prefixIcon: const Icon(Icons.person_outline, color: AppColors.greyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          errorText: controller.nameError,
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget buildEmailInput(SignUpController controller, double widthSize) {
    return Container(
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
        controller: controller.emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintStyle: const TextStyle(color: AppColors.greyColor),
          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.greyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          errorText: controller.emailError,
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
    );
  }


  Widget buildPasswordInput(SignUpController controller) {
    return Container(
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
        controller: controller.passController,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          errorText: controller.passwordError,
          prefixIcon: const Icon(Icons.lock_outline_rounded,color: AppColors.greyColor,),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primary,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
      ),
    );
  }


  Widget buildConfirmPasswordInput(SignUpController controller) {
    return Container(
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
        controller: controller.confirmPassController,
        obscureText: !_isConfirmPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          errorText: controller.confirmPasswordError,
          prefixIcon: const Icon(Icons.lock_outline_rounded,color: AppColors.greyColor,),
          suffixIcon: IconButton(
            icon: Icon(
              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primary,
            ),
            onPressed: () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget buildPhoneNumberInput(SignUpController controller) {
    return Container(
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
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          controller.phoneNumber = number.phoneNumber;
          controller.countryCode = number.dialCode;
          print('this is country code ----${number.dialCode}');
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: const TextStyle(color: Colors.black),
        initialValue: controller.initialPhoneNumber,
        textFieldController: controller.phoneController,
        formatInput: false,
        maxLength: 10,
        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
        inputDecoration: InputDecoration(
          labelText: 'Phone Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.whiteColor,
          errorText: controller.phoneError, // Display phone error
        ),
        onSaved: (PhoneNumber number) {
          controller.phoneNumber = number.phoneNumber;
        },
      ),
    );
  }



  Widget buildSocialMediaButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSocialButton('assets/images/apple.png'),
          const SizedBox(width: 20.0),
          buildSocialButton('assets/images/google.png'),
          const SizedBox(width: 20.0),
          buildSocialButton('assets/images/facebook.png'),
        ],
      ),
    );
  }

  // Helper method to build each Social Media Button
  Widget buildSocialButton(String assetPath) {
    return Container(
      height: 70,
      width: 70,
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
      child: Image.asset(assetPath, scale: 1.5),
    );
  }
}
