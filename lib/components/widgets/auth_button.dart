import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/components/color/appcolors.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final bool circularLoader;
  final VoidCallback? onTap;

  const AuthButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.circularLoader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          color: AppColor.buttonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: circularLoader
              ? CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.bgColor),
                )
              : Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.bgColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
