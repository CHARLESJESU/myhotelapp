import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class ConfirmOrderDialog extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double deliveryFee;
  final double taxes;

  const ConfirmOrderDialog({
    super.key,
    required this.items,
    required this.deliveryFee,
    required this.taxes,
  });

  double get subtotal => items.fold(
    0.0,
    (s, it) => s + (it['price'] as double) * (it['qty'] as int),
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.cardDark : AppColors.lightCard;
    final titleColor = isDark
        ? AppColors.primaryText
        : AppColors.lightPrimaryText;
    final secondary = isDark
        ? AppColors.secondaryText
        : AppColors.lightSecondaryText;
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;

    final total = subtotal + deliveryFee + taxes;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Confirm Order',
                style: TextStyle(
                  color: titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Please review your order before confirming.',
                style: TextStyle(color: secondary),
              ),
            ),
            const SizedBox(height: 16),

            // items
            ...items.map(
              (it) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${it['qty']}x ${it['title']}',
                        style: TextStyle(
                          color: titleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '\$${((it['price'] as double) * (it['qty'] as int)).toStringAsFixed(2)}',
                      style: TextStyle(color: titleColor),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isDark
                          ? AppColors.cardDark
                          : AppColors.lightCard,
                      foregroundColor: titleColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Cancel',
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
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Confirm Order',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
