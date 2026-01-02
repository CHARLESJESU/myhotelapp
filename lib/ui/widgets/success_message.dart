import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SuccessMessage extends StatelessWidget {
  final String message;
  const SuccessMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.successBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.successIcon),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.successText),
            ),
          ),
        ],
      ),
    );
  }
}
