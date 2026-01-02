import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../services/theme_service.dart';
import 'order_history_screen.dart';

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

    Widget sectionTitle(String text) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: TextStyle(
          color: primaryText,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );

    Widget iconSquare(IconData icon) => Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: btnBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: btnText),
    );

    Widget listRow(String label, {IconData? icon}) => Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          if (icon != null) iconSquare(icon),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: primaryText, fontWeight: FontWeight.w600),
            ),
          ),
          Icon(Icons.chevron_right, color: secondaryText),
        ],
      ),
    );

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
            Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: cardBg,
                      child: const Icon(
                        Icons.person,
                        size: 48,
                        color: AppColors.buttonBg,
                      ),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: btnBg,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: AppColors.buttonText,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Jane Doe',
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'jane.doe@email.com',
                  style: TextStyle(color: secondaryText),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  sectionTitle('Account'),
                  listRow('Personal Information', icon: Icons.person),
                  const SizedBox(height: 8),
                  listRow('My Addresses', icon: Icons.place),
                  const SizedBox(height: 8),
                  listRow('Payment Methods', icon: Icons.credit_card),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => OrderHistoryScreen()),
                    ),
                    child: listRow('Order History', icon: Icons.receipt_long),
                  ),

                  const SizedBox(height: 16),
                  sectionTitle('Settings'),
                  // notifications
                  Container(
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        iconSquare(Icons.notifications),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                              color: primaryText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Switch(
                          value: _notifications,
                          activeColor: btnBg,
                          onChanged: (v) => setState(() => _notifications = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // appearance
                  Container(
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        iconSquare(Icons.brightness_6),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Appearance',
                            style: TextStyle(
                              color: primaryText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // simple segmented control
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.cardDark
                                : AppColors.lightCard,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              _appearanceOption('Light'),
                              _appearanceOption('Dark'),
                              _appearanceOption('System'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  sectionTitle('Support & Legal'),
                  listRow('Help & Support', icon: Icons.help_outline),
                  const SizedBox(height: 8),
                  listRow('About', icon: Icons.info_outline),

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

  Widget _appearanceOption(String label) => GestureDetector(
    onTap: () {
      setState(() => _appearance = label);
      // Apply global theme immediately
      if (label == 'Light') ThemeService.setThemeMode(ThemeMode.light);
      if (label == 'Dark') ThemeService.setThemeMode(ThemeMode.dark);
      if (label == 'System') ThemeService.setThemeMode(ThemeMode.system);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: _appearance == label ? AppColors.buttonBg : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _appearance == label
              ? AppColors.buttonText
              : AppColors.secondaryText,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
