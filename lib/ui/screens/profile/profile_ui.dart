import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../services/theme_service.dart';
import '../order_history/order_history_ui.dart';
import 'widget/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDark;
  const ProfileScreen({super.key, this.isDark = true});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;
  String _appearance = 'Dark'; // Light | Dark | System

  @override
  void initState() {
    super.initState();
    final mode = ThemeService.current;
    _appearance = mode == ThemeMode.dark
        ? 'Dark'
        : mode == ThemeMode.light
        ? 'Light'
        : 'System';
    // Keep UI in sync if theme changes elsewhere
    ThemeService.themeMode.addListener(_onThemeModeChanged);
  }

  @override
  void dispose() {
    ThemeService.themeMode.removeListener(_onThemeModeChanged);
    super.dispose();
  }

  void _onThemeModeChanged() {
    final mode = ThemeService.current;
    setState(() {
      _appearance = mode == ThemeMode.dark
          ? 'Dark'
          : mode == ThemeMode.light
          ? 'Light'
          : 'System';
    });
  }

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
    final btnBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final btnText = isDark ? AppColors.buttonText : AppColors.lightButtonText;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(color: primaryText, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            // avatar + name
            ProfileHeader(
              cardBg: cardBg,
              btnBg: btnBg,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  ProfileSectionTitle(text: 'Account', primaryText: primaryText),
                  ProfileListRow(
                    label: 'Personal Information',
                    icon: Icons.person,
                    cardBg: cardBg,
                    btnBg: btnBg,
                    btnText: btnText,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                  ),
                  const SizedBox(height: 8),
                  ProfileListRow(
                    label: 'My Addresses',
                    icon: Icons.place,
                    cardBg: cardBg,
                    btnBg: btnBg,
                    btnText: btnText,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                  ),
                  const SizedBox(height: 8),
                  ProfileListRow(
                    label: 'Payment Methods',
                    icon: Icons.credit_card,
                    cardBg: cardBg,
                    btnBg: btnBg,
                    btnText: btnText,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => OrderHistoryScreen()),
                    ),
                    child: ProfileListRow(
                      label: 'Order History',
                      icon: Icons.receipt_long,
                      cardBg: cardBg,
                      btnBg: btnBg,
                      btnText: btnText,
                      primaryText: primaryText,
                      secondaryText: secondaryText,
                    ),
                  ),

                  const SizedBox(height: 16),
                  ProfileSectionTitle(text: 'Settings', primaryText: primaryText),
                  // notifications
                  NotificationToggleRow(
                    notifications: _notifications,
                    onChanged: (v) => setState(() => _notifications = v),
                    cardBg: cardBg,
                    btnBg: btnBg,
                    btnText: btnText,
                    primaryText: primaryText,
                  ),
                  const SizedBox(height: 8),
                  // appearance
                  AppearanceRow(
                    appearance: _appearance,
                    onAppearanceChanged: (label) {
                      setState(() => _appearance = label);
                      // Apply global theme immediately
                      if (label == 'Light') ThemeService.setThemeMode(ThemeMode.light);
                      if (label == 'Dark') ThemeService.setThemeMode(ThemeMode.dark);
                      if (label == 'System') ThemeService.setThemeMode(ThemeMode.system);
                    },
                    cardBg: cardBg,
                    btnBg: btnBg,
                    btnText: btnText,
                    primaryText: primaryText,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 16),
                  ProfileSectionTitle(text: 'Support & Legal', primaryText: primaryText),
                  ProfileListRow(
                    label: 'Help & Support',
                    icon: Icons.help_outline,
                    cardBg: cardBg,
                    btnBg: btnBg,
                    btnText: btnText,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                  ),
                  const SizedBox(height: 8),
                  ProfileListRow(
                    label: 'About',
                    icon: Icons.info_outline,
                    cardBg: cardBg,
                    btnBg: btnBg,
                    btnText: btnText,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                  ),

                  const SizedBox(height: 28),
                  // logout button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: btnBg,
                        foregroundColor: btnText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Log Out',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
