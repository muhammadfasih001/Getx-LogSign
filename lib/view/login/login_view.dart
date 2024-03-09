import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/components/color/appcolors.dart';
import 'package:task/controller/logIn_controller.dart';
import 'package:task/view/forgot/forgot_pass_view.dart';
import 'package:task/view/signup/signUp.view.dart';
import 'package:task/components/widgets/auth_button.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});

  final LoginController loginController =
      Get.put<LoginController>(LoginController());

  final GlobalKey<FormState> logInKeyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginController loginController =
        Get.put<LoginController>(LoginController());
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
                        key: logInKeyForm,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: loginController.emailController,
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
                              obscureText: loginController.isPassVisible.value,
                              controller: loginController.passwordController,
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    loginController.passwordVisibility();
                                  },
                                  child: Icon(
                                    loginController.isPassVisible.value
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
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 115),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => ForgotPasswordView());
                                },
                                child: Text(
                                  "Forgot password",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
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
                        circularLoader: loginController.circularLoader.value,
                        title: "Log In",
                        onTap: () {
                          if (logInKeyForm.currentState!.validate()) {
                            loginController.loginWithEmailAndPAssword(context);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 680,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpView()));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 23,
                            color: AppColor.buttonColor,
                          ),
                        ),
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
