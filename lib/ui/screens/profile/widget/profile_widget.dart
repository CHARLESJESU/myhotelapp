import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

/// Profile header widget with avatar and name
class ProfileHeader extends StatelessWidget {
  final Color cardBg;
  final Color btnBg;
  final Color primaryText;
  final Color secondaryText;

  const ProfileHeader({
    super.key,
    required this.cardBg,
    required this.btnBg,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

/// Section title widget
class ProfileSectionTitle extends StatelessWidget {
  final String text;
  final Color primaryText;

  const ProfileSectionTitle({
    super.key,
    required this.text,
    required this.primaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
  }
}

/// Icon square widget
class ProfileIconSquare extends StatelessWidget {
  final IconData icon;
  final Color btnBg;
  final Color btnText;

  const ProfileIconSquare({
    super.key,
    required this.icon,
    required this.btnBg,
    required this.btnText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: btnBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: btnText),
    );
  }
}

/// Profile list row widget
class ProfileListRow extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color cardBg;
  final Color btnBg;
  final Color btnText;
  final Color primaryText;
  final Color secondaryText;

  const ProfileListRow({
    super.key,
    required this.label,
    this.icon,
    required this.cardBg,
    required this.btnBg,
    required this.btnText,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          if (icon != null)
            ProfileIconSquare(icon: icon!, btnBg: btnBg, btnText: btnText),
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
  }
}

/// Notification toggle row widget
class NotificationToggleRow extends StatelessWidget {
  final bool notifications;
  final ValueChanged<bool> onChanged;
  final Color cardBg;
  final Color btnBg;
  final Color btnText;
  final Color primaryText;

  const NotificationToggleRow({
    super.key,
    required this.notifications,
    required this.onChanged,
    required this.cardBg,
    required this.btnBg,
    required this.btnText,
    required this.primaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ProfileIconSquare(icon: Icons.notifications, btnBg: btnBg, btnText: btnText),
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
            value: notifications,
            activeColor: btnBg,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Appearance row widget
class AppearanceRow extends StatelessWidget {
  final String appearance;
  final ValueChanged<String> onAppearanceChanged;
  final Color cardBg;
  final Color btnBg;
  final Color btnText;
  final Color primaryText;
  final bool isDark;

  const AppearanceRow({
    super.key,
    required this.appearance,
    required this.onAppearanceChanged,
    required this.cardBg,
    required this.btnBg,
    required this.btnText,
    required this.primaryText,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ProfileIconSquare(icon: Icons.brightness_6, btnBg: btnBg, btnText: btnText),
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
                _AppearanceOption(
                  label: 'Light',
                  isSelected: appearance == 'Light',
                  onTap: () => onAppearanceChanged('Light'),
                ),
                _AppearanceOption(
                  label: 'Dark',
                  isSelected: appearance == 'Dark',
                  onTap: () => onAppearanceChanged('Dark'),
                ),
                _AppearanceOption(
                  label: 'System',
                  isSelected: appearance == 'System',
                  onTap: () => onAppearanceChanged('System'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AppearanceOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AppearanceOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.buttonBg : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColors.buttonText
                : AppColors.secondaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
