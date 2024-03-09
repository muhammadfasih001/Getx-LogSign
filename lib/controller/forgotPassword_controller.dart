import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/view/login/login_view.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  RxBool circularLoader = false.obs;

  void sendPasswordResetEmail(BuildContext context) async {
    circularLoader.value = true;

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Get.snackbar('Password reset link sent', 'Check your email please');
      circularLoader.value = false;
      emailController.clear();

      Get.off(() => LogInView());
    } catch (error) {
      Get.snackbar('Error sending reset link', ' ${error.toString()}');
      circularLoader.value = false;
    }
  }
}
