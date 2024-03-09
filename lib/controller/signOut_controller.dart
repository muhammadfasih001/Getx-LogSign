import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task/view/login/login_view.dart';

class SignOutController extends GetxController {
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar("Sign Out", "Successfully");
      Get.offAll(() => LogInView());
    } catch (e) {
      print("Error signing out: $e");
      Get.snackbar("Error signing out", "$e");
    }
  }
}
