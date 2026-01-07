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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.screenBackground,
      appBar: AppBar(
        backgroundColor: colors.screenBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'My Profile',
          style: TextStyle(color: colors.primaryText, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            // avatar + name
            ProfileHeader(
              cardBg: colors.card,
              btnBg: colors.buttonBg,
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  ProfileSectionTitle(text: 'Account', primaryText: colors.primaryText),
                  ProfileListRow(
                    label: 'Personal Information',
                    icon: Icons.person,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),
                  const SizedBox(height: 8),
                  ProfileListRow(
                    label: 'My Addresses',
                    icon: Icons.place,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),
                  const SizedBox(height: 8),
                  ProfileListRow(
                    label: 'Payment Methods',
                    icon: Icons.credit_card,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => OrderHistoryScreen()),
                    ),
                    child: ProfileListRow(
                      label: 'Order History',
                      icon: Icons.receipt_long,
                      cardBg: colors.card,
                      btnBg: colors.buttonBg,
                      btnText: colors.buttonText,
                      primaryText: colors.primaryText,
                      secondaryText: colors.secondaryText,
                    ),
                  ),

                  const SizedBox(height: 16),
                  ProfileSectionTitle(text: 'Settings', primaryText: colors.primaryText),
                  // notifications
                  NotificationToggleRow(
                    notifications: _notifications,
                    onChanged: (v) => setState(() => _notifications = v),
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                  ),
                  const SizedBox(height: 8),
                  // appearance
                  AppearanceRow(
                    appearance: ThemeService.appearanceLabel,
                    onAppearanceChanged: (label) {
                      // Apply global theme immediately
                      if (label == 'Light') ThemeService.setThemeMode(ThemeMode.light);
                      if (label == 'Dark') ThemeService.setThemeMode(ThemeMode.dark);
                      if (label == 'System') ThemeService.setThemeMode(ThemeMode.system);
                    },
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    isDark: context.isDarkMode,
                  ),

                  const SizedBox(height: 16),
                  ProfileSectionTitle(text: 'Support & Legal', primaryText: colors.primaryText),
                  ProfileListRow(
                    label: 'Help & Support',
                    icon: Icons.help_outline,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),
                  const SizedBox(height: 8),
                  ProfileListRow(
                    label: 'About',
                    icon: Icons.info_outline,
                    cardBg: colors.card,
                    btnBg: colors.buttonBg,
                    btnText: colors.buttonText,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                  ),

                  const SizedBox(height: 28),
                  // logout button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.buttonBg,
                        foregroundColor: colors.buttonText,
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
