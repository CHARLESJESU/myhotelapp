import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../language/language_controller.dart';

/// Lock icon circle widget for forgot password screen
class LockIconCircle extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;

  const LockIconCircle({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.lock_open, size: 48, color: iconColor),
      ),
    );
  }
}

/// Custom text field widget for forgot password screen
class ForgotPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color primaryText;
  final Color secondaryText;
  final Color inputBg;
  final Color borderDefault;

  const ForgotPasswordTextField({
    super.key,
    required this.controller,
    required this.primaryText,
    required this.secondaryText,
    required this.inputBg,
    required this.borderDefault,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: primaryText),
      decoration: InputDecoration(
        filled: true,
        fillColor: inputBg,
        hintText: Get.find<LanguageController>().tr('enter_email_username'),
        hintStyle: TextStyle(color: secondaryText),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderActive),
        ),
      ),
    );
  }
}
