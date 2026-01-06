import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

/// Appearance selector widget for switching between Light, Dark, and System themes
class AppearanceSelector extends StatelessWidget {
  final String appearance;
  final ValueChanged<String> onAppearanceChanged;

  const AppearanceSelector({
    super.key,
    required this.appearance,
    required this.onAppearanceChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark
        ? AppColors.primaryText
        : AppColors.lightPrimaryText;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            'Appearance',
            style: TextStyle(
              color: primaryText,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
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
