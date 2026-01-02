import 'package:flutter/material.dart';

/// Centralized color palette for the app.
///
/// IMPORTANT: Do NOT use direct color literals like `Color(0xFF...)` or hex
/// color codes in screens or widgets. Always reference the constants defined
/// here (e.g., `AppColors.buttonBg`) to keep styling consistent and themeable.
///
/// This file only defines constants; it does NOT change the app theme or
/// override existing theme values. Use these constants where you need specific
/// color values in UI-only widgets.
class AppColors {
  // Success message colors (changed from green to light greys per design request)
  static const Color success = Color(0xFFBDBDBD); // light grey (was green)
  static const Color successBackground = Color(
    0xFFF5F5F5,
  ); // very light grey (was green background)

  // Example additional colors (do not change app theme by using these globally)
  // Primary (branding) color used across the app
  static const Color accentOrange = Color(
    0xFFF5A623,
  ); // #F5A623 (Orange / Amber)
  static const Color backgroundDark = Color(0xFF2B1F1A);
  static const Color cardDark = Color(0xFF3A2D29);

  // Palette requested for Add New Recipe screen
  static const Color screenBackground = Color(0xFF1C120B);
  static const Color inputBackground = Color(0xFF2A1E16);
  static const Color borderDefault = Color(0xFF3A2A20);
  static const Color borderActive = Color(0xFFFF7A18);

  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB8A89A);
  static const Color disabledText = Color(0xFF7A6A5C);

  // Buttons and active highlights use the primary accent color
  static const Color buttonBg = Color(0xFFF5A623); // #F5A623 (Primary Orange)
  static const Color buttonText = Color(0xFFFFFFFF);
  static const Color buttonShadow = Color(0xFFEDB26A);

  static const Color successBg = Color(0xFFBDBDBD); // light grey
  static const Color successIcon = Color(0xFF9E9E9E); // medium grey
  static const Color successText = Color(
    0xFF757575,
  ); // dark-ish grey for contrast

  static const Color uploadDashed = Color(0xFFFF7A18);
  static const Color uploadIcon = Color(0xFFFF7A18);
  static const Color uploadPlaceholder = Color(0xFF2A1E16);

  static const Color deleteText = Color(0xFFE74C3C);

  static const Color appBarBg = Color(0xFF1C120B);
  static const Color appBarText = Color(0xFFFFFFFF);
  static const Color appBarIcon = Color(0xFFFFFFFF);

  // Light theme variants (use these from screens when light mode is active)
  // Colors below are the canonical Light Theme palette — use ONLY these for light-mode UI.
  static const Color lightScreenBackground = Color(
    0xFFFAF7F2,
  ); // Off-white / Cream (#FAF7F2)
  static const Color lightInputBackground = Color(
    0xFFFDF8F3,
  ); // Slightly warm input background
  static const Color lightBorderDefault = Color(0xFFF0E6DA);
  static const Color lightPrimaryText = Color(
    0xFF1F1F1F,
  ); // Dark Charcoal (#1F1F1F)
  static const Color lightSecondaryText = Color(0xFF7A7A7A); // Grey (#7A7A7A)
  static const Color lightButtonBg = Color(
    0xFFF5A623,
  ); // Primary Orange (#F5A623)
  static const Color lightButtonText = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF); // Pure white
  static const Color lightOffer = Color(
    0xFFF8C35A,
  ); // Soft Yellow for offers (#F8C35A)
  static const Color lightBottomNavInactive = Color(
    0xFFB0B0B0,
  ); // Inactive nav color (#B0B0B0)
  static const Color lightBottomNavActive = Color(
    0xFFF5A623,
  ); // Active nav color matches primary (#F5A623)
}
