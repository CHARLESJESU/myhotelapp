import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../services/auth_service.dart';
import '../../../services/database_service.dart';
import '../../../services/theme_service.dart';
import '../../../language/language_service.dart';
import '../../../language/language_controller.dart';
import '../../router/routing.dart';
import 'widget/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDark;
  const ProfileScreen({super.key, this.isDark = true});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Get responsive values
    final padding = ResponsiveHelper.getResponsivePaddingLTRB(
      context,
      leftPercentage: 0.04,
      topPercentage: 0.015,
      rightPercentage: 0.04,
      bottomPercentage: 0.02,
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
      28,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
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
    return Scaffold(
      backgroundColor: colors.screenBackground,
      appBar: AppBar(
        backgroundColor: colors.screenBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.primaryText),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          Get.find<LanguageController>().tr('my_profile'),
          style: TextStyle(
            color: colors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          padding.left,
          padding.top,
          padding.right,
          padding.bottom,
        ),
        child: Column(
          children: [
            // avatar + name
            ProfileHeader(
              cardBg: colors.card,
              btnBg: colors.buttonBg,
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
            ),
            SizedBox(height: mediumSpacing),
            Expanded(
              child: ListView(
                children: [
                  ProfileSectionTitle(
                    text: Get.find<LanguageController>().tr('account'),
                    primaryText: colors.primaryText,
                  ),
                  ProfileListRow(
                    label: Get.find<LanguageController>().tr('personal_information'),
                    icon: Icons.person,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),
                  SizedBox(height: smallSpacing),
                  ProfileListRow(
                    label: Get.find<LanguageController>().tr('my_addresses'),
                    icon: Icons.place,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),
                  SizedBox(height: smallSpacing),
                  ProfileListRow(
                    label: Get.find<LanguageController>().tr('payment_methods'),
                    icon: Icons.credit_card,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),
                  SizedBox(height: smallSpacing),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.orderHistory),
                    child: ProfileListRow(
                      label: Get.find<LanguageController>().tr('order_history'),
                      icon: Icons.receipt_long,
                      cardBg: colors.card,
                      btnBg: colors.buttonBg,
                      btnText: colors.buttonText,
                      primaryText: colors.primaryText,
                      secondaryText: colors.secondaryText,
                    ),
                  ),

                  SizedBox(height: mediumSpacing),
                  ProfileSectionTitle(
                    text: Get.find<LanguageController>().tr('settings'),
                    primaryText: colors.primaryText,
                  ),
                  // notifications
                  NotificationToggleRow(
                    notifications: _notifications,
                    onChanged: (v) => setState(() => _notifications = v),
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                  ),
                  SizedBox(height: smallSpacing),
                  // appearance
                  AppearanceRow(
                    appearance: ThemeService.internalThemeValue,
                    onAppearanceChanged: (label) {
                      // Apply global theme immediately
                      if (label == 'Light')
                        ThemeService.setThemeMode(ThemeMode.light);
                      else if (label == 'Dark')
                        ThemeService.setThemeMode(ThemeMode.dark);
                      else if (label == 'System')
                        ThemeService.setThemeMode(ThemeMode.system);
                    },
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    isDark: context.isCurrentThemeDark,
                  ),
                  SizedBox(height: smallSpacing),
                  // language selector
                  LanguageSelectorRow(
                    selectedLanguage: Get.find<LanguageController>().getCurrentLanguageName(),
                    onLanguageChanged: (language) async {
                      switch(language) {
                        case 'English':
                          await Get.find<LanguageController>().changeLanguage('en');
                          break;
                        case 'தமிழ்':
                          await Get.find<LanguageController>().changeLanguage('ta');
                          break;
                        default:
                          await Get.find<LanguageController>().changeLanguage('en');
                          break;
                      }
                    },
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    isDark: context.isCurrentThemeDark,
                  ),

                  SizedBox(height: mediumSpacing),
                  ProfileSectionTitle(
                    text: Get.find<LanguageController>().tr('support_legal'),
                    primaryText: colors.primaryText,
                  ),
                  ProfileListRow(
                    label: Get.find<LanguageController>().tr('help_support'),
                    icon: Icons.help_outline,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),
                  SizedBox(height: smallSpacing),
                  ProfileListRow(
                    label: Get.find<LanguageController>().tr('about'),
                    icon: Icons.info_outline,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),

                  SizedBox(height: largeSpacing),
                  // logout button
                  SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.buttonBg,
                        foregroundColor: colors.buttonText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        // Clear authentication state and user data
                        await AuthService.to.logout();

                        // Navigate to login screen
                        Get.offAllNamed(AppRoutes.login);
                      },
                      child: Text(
                        Get.find<LanguageController>().tr('log_out'),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(height: mediumSpacing),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
