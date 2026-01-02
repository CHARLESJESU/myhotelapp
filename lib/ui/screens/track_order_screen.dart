import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'menu_screen.dart';

class TrackOrderScreen extends StatelessWidget {
  final bool isDark;
  final String orderNumber;
  final String eta;

  const TrackOrderScreen({
    super.key,
    this.isDark = true,
    this.orderNumber = '#123-ABC-456',
    this.eta = '35 - 45 min',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? AppColors.screenBackground
        : AppColors.lightScreenBackground;
    final primaryText = isDark
        ? AppColors.primaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.secondaryText
        : AppColors.lightSecondaryText;
    final cardBg = isDark ? AppColors.cardDark : AppColors.lightCard;
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: primaryText),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 8),
              // image placeholder
              Container(
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
              ),
              const SizedBox(height: 18),
              Text(
                'Your Order is on its\nWay!',
                style: TextStyle(
                  color: primaryText,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Thank you for your order. You can track its progress below.',
                style: TextStyle(color: secondaryText),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),

              Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Number',
                          style: TextStyle(color: secondaryText),
                        ),
                        Text(
                          orderNumber,
                          style: TextStyle(
                            color: primaryText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(height: 1),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Estimated Arrival',
                          style: TextStyle(color: secondaryText),
                        ),
                        Text(
                          eta,
                          style: TextStyle(
                            color: primaryText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonBg,
                    foregroundColor: buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Track Order',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => MenuScreen()),
                ),
                child: Text(
                  'Return to Menu',
                  style: TextStyle(
                    color: buttonBg,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
