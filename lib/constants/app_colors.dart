import 'package:flutter/material.dart';

/// Centralized color palette for the app.
///
/// IMPORTANT: Do NOT use direct color literals like `Color(0xFF...)` or hex
/// color codes in screens or widgets. Always reference the constants defined
/// here to keep styling consistent and themeable.
///
/// Use [DarkModeColors] for dark theme and [LightModeColors] for light theme.

/// Dark mode color palette
class DarkModeColors {
  // Screen backgrounds
  static const Color screenBackground = Color(0xFF1C120B);
  static const Color inputBackground = Color(0xFF2A1E16);
  static const Color card = Color(0xFF3A2D29);
  static const Color appBarBg = Color(0xFF1C120B);

  // Borders
  static const Color borderDefault = Color(0xFF3A2A20);
  static const Color borderActive = Color(0xFFFF7A18);

  // Text colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB8A89A);
  static const Color disabledText = Color(0xFF7A6A5C);
  static const Color appBarText = Color(0xFFFFFFFF);
  static const Color appBarIcon = Color(0xFFFFFFFF);

  // Buttons
  static const Color buttonBg = Color(0xFFF5A623);
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color buttonShadow = Color(0xFFEDB26A);

  // Success states
  static const Color success = Color(0xFFBDBDBD);
  static const Color successBackground = Color(0xFFF5F5F5);
  static const Color successBg = Color(0xFFBDBDBD);
  static const Color successIcon = Color(0xFF9E9E9E);
  static const Color successText = Color(0xFF757575);

  // Upload/placeholder
  static const Color uploadDashed = Color(0xFFFF7A18);
  static const Color uploadIcon = Color(0xFFFF7A18);
  static const Color uploadPlaceholder = Color(0xFF2A1E16);

  // Status tags
  static const Color tagNew = Color(0xFF1CA7B3);
  static const Color tagPreparing = Color(0xFFF8C35A);
  static const Color tagDelivered = Color(0xFF2FB25A);

  // Misc
  static const Color accentOrange = Color(0xFFF5A623);
  static const Color deleteText = Color(0xFFE74C3C);
  static const Color adminDivider = Color(0xFF4A5560);

  // Bottom navigation
  static const Color bottomNavActive = Color(0xFFF5A623);
  static const Color bottomNavInactive = Color(0xFFB8A89A);
}

/// Light mode color palette
class LightModeColors {
  // Screen backgrounds
  static const Color screenBackground = Color(0xFFFAF7F2);
  static const Color inputBackground = Color(0xFFFDF8F3);
  static const Color card = Color(0xFFFFFFFF);
  static const Color appBarBg = Color(0xFFFAF7F2);

  // Borders
  static const Color borderDefault = Color(0xFFF0E6DA);
  static const Color borderActive = Color(0xFFFF7A18);

  // Text colors
  static const Color primaryText = Color(0xFF1F1F1F);
  static const Color secondaryText = Color(0xFF7A7A7A);
  static const Color disabledText = Color(0xFFB0B0B0);
  static const Color appBarText = Color(0xFF1F1F1F);
  static const Color appBarIcon = Color(0xFF1F1F1F);

  // Buttons
  static const Color buttonBg = Color(0xFFF5A623);
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color buttonShadow = Color(0xFFEDB26A);

  // Success states
  static const Color success = Color(0xFFBDBDBD);
  static const Color successBackground = Color(0xFFF5F5F5);
  static const Color successBg = Color(0xFFBDBDBD);
  static const Color successIcon = Color(0xFF9E9E9E);
  static const Color successText = Color(0xFF757575);

  // Upload/placeholder
  static const Color uploadDashed = Color(0xFFFF7A18);
  static const Color uploadIcon = Color(0xFFFF7A18);
  static const Color uploadPlaceholder = Color(0xFFF0E6DA);

  // Status tags
  static const Color tagNew = Color(0xFF1CA7B3);
  static const Color tagPreparing = Color(0xFFF8C35A);
  static const Color tagDelivered = Color(0xFF2FB25A);

  // Misc
  static const Color accentOrange = Color(0xFFF5A623);
  static const Color offer = Color(0xFFF8C35A);
  static const Color deleteText = Color(0xFFE74C3C);
  static const Color adminDivider = Color(0xFFE0E0E0);

  // Bottom navigation
  static const Color bottomNavActive = Color(0xFFF5A623);
  static const Color bottomNavInactive = Color(0xFFB0B0B0);
}

/// Legacy AppColors class for backward compatibility.
/// Prefer using [DarkModeColors] or [LightModeColors] directly.
class AppColors {
  // Success message colors
  static const Color success = Color(0xFFBDBDBD);
  static const Color successBackground = Color(0xFFF5F5F5);

  static const Color accentOrange = Color(0xFFF5A623);
  static const Color backgroundDark = Color(0xFF2B1F1A);
  static const Color cardDark = Color(0xFF3A2D29);

  // Dark theme defaults
  static const Color screenBackground = Color(0xFF1C120B);
  static const Color inputBackground = Color(0xFF2A1E16);
  static const Color borderDefault = Color(0xFF3A2A20);
  static const Color borderActive = Color(0xFFFF7A18);

  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB8A89A);
  static const Color disabledText = Color(0xFF7A6A5C);

  static const Color buttonBg = Color(0xFFF5A623);
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color buttonShadow = Color(0xFFEDB26A);

  static const Color successBg = Color(0xFFBDBDBD);
  static const Color successIcon = Color(0xFF9E9E9E);
  static const Color successText = Color(0xFF757575);

  static const Color uploadDashed = Color(0xFFFF7A18);
  static const Color uploadIcon = Color(0xFFFF7A18);
  static const Color uploadPlaceholder = Color(0xFF2A1E16);

  static const Color deleteText = Color(0xFFE74C3C);

  static const Color appBarBg = Color(0xFF1C120B);
  static const Color appBarText = Color(0xFFFFFFFF);
  static const Color appBarIcon = Color(0xFFFFFFFF);

  // Light theme variants (legacy)
  static const Color lightScreenBackground = Color(0xFFFAF7F2);
  static const Color lightInputBackground = Color(0xFFFDF8F3);
  static const Color lightBorderDefault = Color(0xFFF0E6DA);
  static const Color lightPrimaryText = Color(0xFF1F1F1F);
  static const Color lightSecondaryText = Color(0xFF7A7A7A);
  static const Color lightButtonBg = Color(0xFFF5A623);
  static const Color lightButtonText = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightOffer = Color(0xFFF8C35A);
  static const Color lightBottomNavInactive = Color(0xFFB0B0B0);
  static const Color lightBottomNavActive = Color(0xFFF5A623);

  // Status tags
  static const Color tagNew = Color(0xFF1CA7B3);
  static const Color tagPreparing = Color(0xFFF8C35A);
  static const Color tagDelivered = Color(0xFF2FB25A);
  static const Color adminDivider = Color(0xFF4A5560);
}
