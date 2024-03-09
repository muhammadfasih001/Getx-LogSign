import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/components/color/appcolors.dart';
import 'package:task/controller/signUp_controller.dart';
import 'package:task/view/login/login_view.dart';
import 'package:task/components/widgets/auth_button.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final signUpController = Get.put(SignUpController());
  final signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColor.bgColor,
          systemNavigationBarColor: AppColor.bgColor,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Align(
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 200,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 100,
                    ),
                    child: ClipPath(
                      clipBehavior: Clip.hardEdge,
                      clipper: BackgroundClipper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.width * 1 * 1.33,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  // alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.8 * 0.5,
                    ),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.avatarColor,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 270,
                  left: 50,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 1.5 * 0.5,
                    height: MediaQuery.of(context).size.height * 0.8 * 0.5,
                    child: Obx(
                      () => Form(
                        key: signUpFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              controller: signUpController.emailController,
                              decoration: InputDecoration(
                                hintText: "Email address",
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: AppColor.eHintText,
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
                                  return 'Enter your email';
                                }

                                final emailRegex = RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              obscureText:
                                  signUpController.isPassVisiblePassword.value,
                              controller: signUpController.passwordController,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    signUpController
                                        .passwordVisibilityPassword();
                                  },
                                  child: Icon(
                                    signUpController.isPassVisiblePassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColor.avatarColor,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: AppColor.bgColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
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
                                  return 'Enter your Password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              obscureText: signUpController
                                  .isPassVisibleConfirmPassword.value,
                              controller:
                                  signUpController.confirmPasswordController,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    signUpController
                                        .passwordVisibilityConfirmPassword();
                                  },
                                  child: Icon(
                                    signUpController
                                            .isPassVisibleConfirmPassword.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColor.avatarColor,
                                  ),
                                ),
                                hintText: "Confirm Password",
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: AppColor.bgColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
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
                                  return 'Enter your Confirm Password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 595),
                  child: Align(
                    child: Obx(
                      () => AuthButton(
                        circularLoader: signUpController.circularLoader.value,
                        title: "Sign up",
                        onTap: () {
                          if (signUpFormKey.currentState!.validate()) {
                            signUpController
                                .signUpWithEmailAndPassword(context);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 655, left: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      backgroundColor: AppColor.buttonColor,
                      onPressed: () {
                        Get.to(() => LogInView());
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    dynamic roundnessFactor = 45.0;

    var path = Path();

    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, roundnessFactor * 2);
    path.quadraticBezierTo(size.width - 10, roundnessFactor,
        size.width - roundnessFactor - 1, roundnessFactor * 1);
    path.lineTo(
        roundnessFactor * 1, size.height * 0.33 - roundnessFactor * 0.3);
    path.quadraticBezierTo(
        0, size.height * 0.33, 0, size.height * 0.33 + roundnessFactor);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
