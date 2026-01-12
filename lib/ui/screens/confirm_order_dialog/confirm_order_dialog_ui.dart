import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';

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
    final colors = context.colors;

    // Get responsive values
    final horizontalPadding = ResponsiveHelper.getResponsiveWidth(
      context,
      0.06,
      20,
      32,
    );
    final verticalPadding = ResponsiveHelper.getResponsiveHeight(
      context,
      0.08,
      40,
      64,
    );
    final containerPadding = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.02,
      16,
      24,
    );
    final smallSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.01,
      6,
      10,
    );
    final mediumSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.015,
      10,
      16,
    );
    final largeSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.02,
      16,
      24,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      18,
      22,
    );
    final subtitleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.02,
      14,
      16,
    );
    final totalFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      16,
      20,
    );
    final buttonHeight = ResponsiveHelper.getResponsiveButtonHeight(
      context,
      0.06,
      48,
      60,
    );
    final total = subtotal + deliveryFee + taxes;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(containerPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Confirm Order',
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: smallSpacing),
            Center(
              child: Text(
                'Please review your order before confirming.',
                style: TextStyle(
                  color: colors.secondaryText,
                  fontSize: subtitleFontSize,
                ),
              ),
            ),
            SizedBox(height: mediumSpacing),

            // items
            ...items.map(
              (it) => Padding(
                padding: EdgeInsets.symmetric(vertical: smallSpacing),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${it['qty']}x ${it['title']}',
                        style: TextStyle(
                          color: colors.primaryText,
                          fontWeight: FontWeight.w600,
                          fontSize: subtitleFontSize,
                        ),
                      ),
                    ),
                    Text(
                      '\$${((it['price'] as double) * (it['qty'] as int)).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: colors.primaryText,
                        fontSize: subtitleFontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: mediumSpacing),
            const Divider(height: 1),
            SizedBox(height: mediumSpacing),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: colors.secondaryText,
                    fontWeight: FontWeight.w700,
                    fontSize: subtitleFontSize,
                  ),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: colors.primaryText,
                    fontWeight: FontWeight.w800,
                    fontSize: totalFontSize,
                  ),
                ),
              ],
            ),

            SizedBox(height: mediumSpacing),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: colors.card,
                      foregroundColor: colors.primaryText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Get.back(result: false),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.getResponsiveSpacing(
                          context,
                          0.015,
                          10,
                          16,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: subtitleFontSize,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: mediumSpacing),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.buttonBg,
                      foregroundColor: colors.buttonText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Get.back(result: true),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveHelper.getResponsiveSpacing(
                          context,
                          0.015,
                          10,
                          16,
                        ),
                      ),
                      child: Text(
                        'Confirm Order',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: subtitleFontSize,
                        ),
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
