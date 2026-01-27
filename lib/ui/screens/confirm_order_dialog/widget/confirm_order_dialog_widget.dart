import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../language/language_controller.dart';

/// Order item row widget for confirm dialog
class OrderItemRow extends StatelessWidget {
  final int quantity;
  final String title;
  final double price;
  final Color textColor;

  const OrderItemRow({
    super.key,
    required this.quantity,
    required this.title,
    required this.price,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${quantity}x $title',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '\$${(price * quantity).toStringAsFixed(2)}',
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}

/// Dialog action buttons widget
class DialogActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final Color backgroundColor;
  final Color textColor;
  final Color buttonBg;
  final Color buttonText;

  const DialogActionButtons({
    super.key,
    required this.onCancel,
    required this.onConfirm,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonBg,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: textColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onCancel,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                Get.find<LanguageController>().tr('cancel'),
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBg,
              foregroundColor: buttonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onConfirm,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                Get.find<LanguageController>().tr('confirm_order'),
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
