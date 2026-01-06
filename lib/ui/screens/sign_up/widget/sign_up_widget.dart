import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

/// Sign up icon circle widget
class SignUpIconCircle extends StatelessWidget {
  final Color cardBg;
  final Color iconColor;

  const SignUpIconCircle({
    super.key,
    required this.cardBg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: cardBg,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.fastfood, size: 36, color: iconColor),
      ),
    );
  }
}

/// Password strength bar widget
class PasswordStrengthBar extends StatelessWidget {
  final double strength;
  final String label;
  final Color barColor;
  final Color backgroundColor;
  final Color labelColor;

  const PasswordStrengthBar({
    super.key,
    required this.strength,
    required this.label,
    required this.barColor,
    required this.backgroundColor,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: strength,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: barColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: TextStyle(color: labelColor),
          ),
        ),
      ],
    );
  }
}

/// Sign up text field widget
class SignUpTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color primaryText;
  final Color secondaryText;
  final Color inputBg;
  final Color borderDefault;
  final bool hasError;

  const SignUpTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    required this.primaryText,
    required this.secondaryText,
    required this.inputBg,
    required this.borderDefault,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: primaryText,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
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
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? Colors.red : borderDefault,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? Colors.red : AppColors.borderActive,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
