import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../language/language_controller.dart';
import '../../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool isDark;
  const ForgotPasswordScreen({super.key, this.isDark = true});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  void _onSend() {
    // UI only: show a SnackBar to demonstrate action
    Get.snackbar('Success', 'Reset link sent (UI-only)');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Get responsive values
    final padding = ResponsiveHelper.getResponsivePaddingLTRB(
      context,
      leftPercentage: 0.06,
      topPercentage: 0.03,
      rightPercentage: 0.06,
      bottomPercentage: 0.03,
    );

    final smallSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.015,
      10,
      16,
    );
    final mediumSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.025,
      16,
      24,
    );
    final largeSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.03,
      20,
      30,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      16,
      22,
    );
    final subtitleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.02,
      12,
      16,
    );
    final labelFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.022,
      14,
      18,
    );
    final iconSize = ResponsiveHelper.getResponsiveIconSize(
      context,
      0.04,
      36,
      56,
    );
    final circleSize = ResponsiveHelper.getResponsiveWidth(
      context,
      0.25,
      100,
      140,
    );

    return Scaffold(
      backgroundColor: colors.screenBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            padding.left,
            padding.top,
            padding.right,
            padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // top bar with back arrow and centered title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back, color: colors.primaryText),
                  ),
                  Expanded(
                    child: Text(
                      Get.find<LanguageController>().tr('forgot_password_title'),
                      style: TextStyle(
                        color: colors.primaryText,
                        fontWeight: FontWeight.w700,
                        fontSize: titleFontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 48, // Space for back button
                  ),
                ],
              ),

              SizedBox(height: mediumSpacing),

              // lock icon
              Center(
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    color: colors.card,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.lock_open,
                      size: iconSize,
                      color: colors.buttonBg,
                    ),
                  ),
                ),
              ),

              SizedBox(height: mediumSpacing),

              Center(
                child: Text(
                  Get.find<LanguageController>().tr('forgot_password_subtitle'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize,
                  ),
                ),
              ),

              SizedBox(height: largeSpacing),

              Text(
                Get.find<LanguageController>().tr('email_or_username'),
                style: TextStyle(
                  color: colors.primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: labelFontSize,
                ),
              ),

              SizedBox(height: smallSpacing),

              TextField(
                controller: _emailController,
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: subtitleFontSize,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colors.inputBackground,
                  hintText: Get.find<LanguageController>().tr('enter_email_username'),
                  hintStyle: TextStyle(
                    color: colors.secondaryText,
                    fontSize: subtitleFontSize * 0.9,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderDefault),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colors.borderActive),
                  ),
                ),
              ),

              const Spacer(),

              // bottom button
              Padding(
                padding: EdgeInsets.only(bottom: mediumSpacing),
                child: PrimaryButton(
                  label: Get.find<LanguageController>().tr('send_reset_link'),
                  onPressed: _onSend,
                  backgroundColor: colors.buttonBg,
                  textColor: colors.buttonText,
                  shadowColor: colors.buttonShadow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
