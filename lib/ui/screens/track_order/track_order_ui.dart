import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../language/language_controller.dart';
import '../../router/routing.dart';
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

    // Get responsive values
    final horizontalPadding = ResponsiveHelper.getResponsiveWidth(
      context,
      0.04,
      16,
      24,
    );
    final smallSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.01,
      8,
      12,
    );
    final mediumSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.015,
      12,
      18,
    );
    final largeSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.02,
      16,
      24,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.035,
      22,
      30,
    );
    final subtitleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.022,
      14,
      18,
    );

    return Scaffold(
      backgroundColor: colors.screenBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: colors.primaryText),
                  onPressed: () => Get.back(),
                ),
              ),
              SizedBox(height: smallSpacing),

              // Delivery illustration
              const DeliveryIllustration(),

              SizedBox(height: mediumSpacing),
              Text(
                Get.find<LanguageController>().tr('order_on_way'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: smallSpacing),
              Text(
                Get.find<LanguageController>().tr('thank_you_for_order'),
                style: TextStyle(
                  color: colors.secondaryText,
                  fontSize: subtitleFontSize,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: mediumSpacing),

              // Order info card
              OrderInfoCard(
                orderNumber: orderNumber,
                eta: eta,
                cardBg: colors.card,
                primaryText: colors.primaryText,
                secondaryText: colors.secondaryText,
              ),

              SizedBox(height: mediumSpacing),

              // Track Order button
              TrackButton(
                label: Get.find<LanguageController>().tr('track_order'),
                backgroundColor: colors.buttonBg,
                textColor: colors.buttonText,
                onPressed: () {},
              ),

              SizedBox(height: smallSpacing),
              TextButton(
                onPressed: () => Get.offNamed(AppRoutes.menu),
                child: Text(
                  Get.find<LanguageController>().tr('return_to_menu'),
                  style: TextStyle(
                    color: colors.buttonBg,
                    fontWeight: FontWeight.w700,
                    fontSize: subtitleFontSize,
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
