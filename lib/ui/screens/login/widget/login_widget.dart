import 'package:flutter/material.dart';
import '../../../../services/theme_service.dart';

/// Login icon circle widget
class LoginIconCircle extends StatelessWidget {
  final Color cardBg;
  final Color iconColor;

  const LoginIconCircle({
    super.key,
    required this.cardBg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(color: cardBg, shape: BoxShape.circle),
        child: Center(
          child: Icon(Icons.restaurant, size: 48, color: iconColor),
        ),
      ),
    );
  }
}

/// Theme toggle button widget
class ThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final Color cardBg;
  final Color borderColor;
  final Color iconColor;

  const ThemeToggleButton({
    super.key,
    required this.isDark,
    required this.cardBg,
    required this.borderColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: IconButton(
        onPressed: ThemeService.toggle,
        icon: Icon(
          isDark ? Icons.dark_mode : Icons.light_mode,
          color: iconColor,
        ),
      ),
    );
  }
}

/// Custom text field widget for login form
class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color primaryText;
  final Color secondaryText;
  final Color inputBg;
  final Color borderDefault;
  final Color borderActive;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    required this.primaryText,
    required this.secondaryText,
    required this.inputBg,
    required this.borderDefault,
    required this.borderActive,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: primaryText),
      decoration: InputDecoration(
        filled: true,
        fillColor: inputBg,
        hintText: hintText,
        hintStyle: TextStyle(color: secondaryText),
        prefixIcon: Icon(prefixIcon, color: secondaryText),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderActive),
        ),
      ),
    );
  }
}
