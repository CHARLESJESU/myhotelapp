import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? shadowColor;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: textColor,
      elevation: shadowColor != null ? 6 : 0,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    );

    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: style,
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: textColor)),
      ),
    );
  }
}
