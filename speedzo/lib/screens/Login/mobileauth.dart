// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k/screens/Doc_Verification/aadhar.dart';
import 'otpscreen.dart';

class AuthWithNumber extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController number = TextEditingController();
  TextEditingController otp = TextEditingController();
  String verifyId = '';
  AuthWithNumber(TextEditingController number);

  void numberLogin() async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "+91${number.text}",
        verificationCompleted: (PhoneAuthCredential credential) {
          print(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyId = verificationId;
          Get.to(() => const Otp());
          Get.snackbar(
              backgroundColor: Colors.black,
              colorText: Colors.white,
              "OTP Sent",
              "OTP has been sent on ${number.text}");
          print(
            "OTP SENDED",
          );
          print(User);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar("${e}", "");

      print(e);
    }
  }

  void verifyNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode: otp.text,
      );
      await auth.signInWithCredential(credential);
      Get.to(() => const Aadhar());
    } catch (e) {
      Get.snackbar("OTP verified", "Welcome to SPEEDZO",
          colorText: Colors.white, backgroundColor: Colors.black);
      print(e);
    }
  }
}
