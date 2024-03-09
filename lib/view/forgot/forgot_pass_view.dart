import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/components/color/appcolors.dart';
import 'package:task/components/widgets/auth_button.dart';
import 'package:task/controller/forgotPassword_controller.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  final GlobalKey<FormState> forgotKeyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: forgotKeyForm,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Forgot Password",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Enter your registered email below to receive password reset instruction \u{1F511}",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: forgotPasswordController.emailController,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.bgColor,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: AppColor.avatarColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.eHintText,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.fHintText,
                      width: 1.5,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your Email address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => AuthButton(
                  title: "Send",
                  circularLoader: forgotPasswordController.circularLoader.value,
                  onTap: () {
                    if (forgotKeyForm.currentState!.validate()) {
                      forgotPasswordController.sendPasswordResetEmail(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
