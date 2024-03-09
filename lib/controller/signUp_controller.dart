import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/view/login/login_view.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isPassVisiblePassword = true.obs;
  final isPassVisibleConfirmPassword = true.obs;
  RxBool circularLoader = false.obs;

  signUpWithEmailAndPassword(BuildContext context) async {
    circularLoader.value = true;
    String emailAdd = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String confirmPassword = confirmPasswordController.text.toString().trim();

    if (emailAdd == "" || password == "" || confirmPassword == "") {
      Get.snackbar("Sign up Error", "Please Fill All The Values");
      circularLoader.value = false;
    } else if (password != confirmPassword) {
      Get.snackbar("Sign up Error", "Password do not match");
      circularLoader.value = false;
    } else {
      try {
        circularLoader.value = true;
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAdd,
          password: password,
        );

        if (credential.user != null) {
          circularLoader.value = false;
          Get.snackbar("Sign Up Successfully",
              "User with email $emailAdd registered successfully");
          clearControllers();
          Get.to(() => LogInView());
        }
      } on FirebaseAuthException catch (e) {
        circularLoader.value = false;
        Get.snackbar("Error", e.message ?? "An error occurred");
      } catch (e) {
        circularLoader.value = false;
        Get.snackbar("Error", e.toString());
      }
    }
  }

  passwordVisibilityPassword() {
    isPassVisiblePassword.value = !isPassVisiblePassword.value;
  }

  passwordVisibilityConfirmPassword() {
    isPassVisibleConfirmPassword.value = !isPassVisibleConfirmPassword.value;
  }

  clearControllers() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
