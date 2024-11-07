import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:machine_test/controller/app_base_controller/app_base_conroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import '../route_management/routes.dart';


class LoginController extends AppBaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController phoneController = TextEditingController();
  String? verificationId;
  bool isLoading = false;
  String? phoneError;
  String? countryCode;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print('Arguments: ${Get.arguments}');
    if (Get.arguments != null) {
      countryCode = Get.arguments;
      print('Country code: $countryCode');
    } else {
      countryCode = '+91';
      print('Default country code: $countryCode');
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  Future<void> getOTP(code) async {

    if (phoneController.text.isEmpty || !RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phoneController.text)) {
      phoneError = 'Please enter a valid phone number';
      update();

      return ;
    }

    phoneError = null;
    isLoading = true;
    update();
    try {
      print('this is country code register----${code}');
      final phoneNumber = '${code??countryCode}${phoneController.text}';
      print('-----phone number with country code ----${phoneNumber}');
      final querySnapshot = await _firestore.collection('users').where('phoneNumber', isEqualTo: phoneNumber).get();

      if (querySnapshot.docs.isEmpty) {
        Get.snackbar('Error', 'This phone number is not registered. Please sign up first.');
        isLoading = false;
        update();
        return;
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.toNamed(homeScreen);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', e.message ?? 'Unknown error');
          isLoading = false;
          update();
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          Get.toNamed(otpScreen, arguments: verificationId);
          isLoading = false;
          update();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
          isLoading = false;
          update();
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify phone number. Please try again.');
      isLoading = false;
      update();
    }
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        String? userName = user.displayName; // Fetches the user's name
        String? userEmail = user.email;
        String? userPhotoUrl = user.photoURL;

        print('Google User Name: $userName');
        print('Google User Email: $userEmail');
        print('Google User Photo URL: $userPhotoUrl');

        await _firestore.collection('users').doc(user.uid).set({
          'name': userName,
          'email': userEmail,
          'photoUrl': userPhotoUrl,
        });
        Get.toNamed(homeScreen);

      }


    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

}


