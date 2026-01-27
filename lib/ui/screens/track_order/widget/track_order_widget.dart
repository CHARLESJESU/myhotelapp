import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../language/language_controller.dart';

/// Delivery illustration placeholder widget
class DeliveryIllustration extends StatelessWidget {
  const DeliveryIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.uploadPlaceholder,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(
          Icons.delivery_dining,
          size: 72,
          color: AppColors.buttonBg,
        ),
      ),
    );
  }
}

/// Order information card widget
class OrderInfoCard extends StatelessWidget {
  final String orderNumber;
  final String eta;
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;

  const OrderInfoCard({
    super.key,
    required this.orderNumber,
    required this.eta,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          OrderInfoRow(
            label: Get.find<LanguageController>().tr('order_number'),
            value: orderNumber,
            labelColor: secondaryText,
            valueColor: primaryText,
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          const SizedBox(height: 10),
          OrderInfoRow(
            label: Get.find<LanguageController>().tr('estimated_arrival'),
            value: eta,
            labelColor: secondaryText,
            valueColor: primaryText,
          ),
        ],
      ),
    );
  }
}

/// Order info row widget
class OrderInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;

  const OrderInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.labelColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: labelColor),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Track order button widget
class TrackButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const TrackButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
