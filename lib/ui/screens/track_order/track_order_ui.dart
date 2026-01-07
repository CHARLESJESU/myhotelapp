import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../menu/menu_ui.dart';
import 'widget/track_order_widget.dart';

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
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.screenBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: colors.primaryText),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 8),
              
              // Delivery illustration
              const DeliveryIllustration(),
              
              const SizedBox(height: 18),
              Text(
                'Your Order is on its\nWay!',
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Thank you for your order. You can track its progress below.',
                style: TextStyle(color: colors.secondaryText),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),

              // Order info card
              OrderInfoCard(
                orderNumber: orderNumber,
                eta: eta,
                cardBg: colors.card,
                primaryText: colors.primaryText,
                secondaryText: colors.secondaryText,
              ),

              const SizedBox(height: 18),
              
              // Track Order button
              TrackButton(
                label: 'Track Order',
                backgroundColor: colors.buttonBg,
                textColor: colors.buttonText,
                onPressed: () {},
              ),
              
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => MenuScreen()),
                ),
                child: Text(
                  'Return to Menu',
                  style: TextStyle(
                    color: colors.buttonBg,
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
