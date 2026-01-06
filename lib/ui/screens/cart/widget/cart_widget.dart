import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

/// Cart item card widget
class CartItemCard extends StatelessWidget {
  final String title;
  final double price;
  final int qty;
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.qty,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.uploadPlaceholder,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: primaryText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(color: secondaryText),
                ),
              ],
            ),
          ),
          Row(
            children: [
              QuantityButton(label: '-', onTap: onDecrement),
              const SizedBox(width: 8),
              Text(
                '$qty',
                style: TextStyle(color: primaryText),
              ),
              const SizedBox(width: 8),
              QuantityButton(label: '+', onTap: onIncrement),
            ],
          ),
        ],
      ),
    );
  }
}

/// Quantity adjustment button widget
class QuantityButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const QuantityButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Text(
          label,
          style: const TextStyle(
            color: AppColors.buttonText,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}

/// Summary row widget for displaying cart totals
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color primaryText;
  final Color secondaryText;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: secondaryText)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(color: primaryText, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
