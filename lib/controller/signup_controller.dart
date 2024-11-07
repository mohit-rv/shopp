import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:machine_test/auth_module/login_view.dart';
import 'package:machine_test/controller/app_base_controller/app_base_conroller.dart';



class SignUpController extends AppBaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); // Add this line

  PhoneNumber initialPhoneNumber = PhoneNumber(isoCode: 'IN');
  String? phoneNumber;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? phoneError;
  String? nameError;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? countryCode;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    phoneController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void validateForm() {
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    phoneError = null;
    nameError = null;
    update();

    if (nameController.text.isEmpty) {
      nameError = 'Please enter your name';
    } else if (emailController.text.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(emailController.text)) {
      emailError = 'Please enter a valid email address';
    } else if (passController.text.isEmpty || passController.text.length < 8) {
      passwordError = 'Password must be at least 8 characters';
    } else if (confirmPassController.text.isEmpty ||
        confirmPassController.text != passController.text) {
      confirmPasswordError = 'Passwords do not match';
    } else if (phoneNumber == null || phoneNumber!.isEmpty || !RegExp(r'^\+\d{10,15}$').hasMatch(phoneNumber!)) {
      phoneError = 'Please enter a valid phone number';
    } else {
      registerUser();
    }
    update();
  }

  Future<void> registerUser() async {
    try {
      Get.snackbar('Loading', 'Creating your account...',
          showProgressIndicator: true, duration: const Duration(seconds: 2));

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': nameController.text.trim(), // Add this line
          'email': user.email,
          'phoneNumber': phoneNumber,
          'createdAt': DateTime.now(),
        });

        Get.snackbar('Success', 'Account created successfully!');
        Get.to(LoginScreen(code: countryCode));

      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'email-already-in-use':
          message = 'The email is already in use. Please use a different email.';
          break;
        case 'weak-password':
          message = 'The password is too weak.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An unknown error occurred. Please try again.';
      }

      Get.snackbar('Error', message);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    }
  }
}




