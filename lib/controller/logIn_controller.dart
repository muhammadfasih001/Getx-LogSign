import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/view/home/home_view.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isPassVisible = true.obs;
  RxBool circularLoader = false.obs;
  GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();

  loginWithEmailAndPAssword(BuildContext context) async {
    circularLoader.value = true;

    String emailAdd = emailController.text.trim();
    String password = passwordController.text.trim();

    if (emailAdd.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please Enter Username and Password");
      circularLoader.value = false;
      return;
    } else {
      try {
        circularLoader.value = true;
        final UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: emailAdd, password: password);

        Get.snackbar("Log In Successfully",
            "User with email $emailAdd Log In successfully");
        final User? user = credential.user;
        if (user != null) {
          Get.offAll(() => HomeView());

          circularLoader.value = false;
          clearControllers();
        } else {
          Get.snackbar("Login Error", "You are not a registered user");
        }
      } on FirebaseException catch (e) {
        if (e.code == 'wrong-password') {
          circularLoader.value = false;
          Get.snackbar("The password is Incorrect", "Please try again.");
        } else if (e.code == 'user-not-found') {
          circularLoader.value = false;
          Get.snackbar("There is no user associated with this email",
              "The user may have been deleted.");
        } else if (e.code == 'invalid-email') {
          Get.snackbar("The email is not valid", "Please check and try again.");
        } else if (e.code == 'invalid-email') {
          Get.snackbar("The email is not valid", "Please check and try again.");
        } else {
          circularLoader.value = false;
          Get.snackbar("Something went wrong", "Please try again");
        }
      } catch (error) {
        circularLoader.value = false;
        Get.snackbar("An error occurred", "$error");
      } finally {
        circularLoader.value = false;
      }
    }
  }

  passwordVisibility() {
    isPassVisible.value = !isPassVisible.value;
  }

  clearControllers() {
    emailController.clear();
    passwordController.clear();
  }
}
