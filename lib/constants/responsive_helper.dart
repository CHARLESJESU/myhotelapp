import 'package:flutter/material.dart';

/// A responsive helper class to handle responsive UI elements
class ResponsiveHelper {
  /// Get responsive padding based on screen dimensions
  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    double horizontalPercentage = 0.04,
    double verticalPercentage = 0.015,
    double minHorizontal = 16.0,
    double maxHorizontal = 24.0,
    double minVertical = 8.0,
    double maxVertical = 16.0,
  }) {
    final size = MediaQuery.of(context).size;
    double horizontal = size.width * horizontalPercentage;
    double vertical = size.height * verticalPercentage;
    
    // Clamp values to min/max
    horizontal = horizontal.clamp(minHorizontal, maxHorizontal).toDouble();
    vertical = vertical.clamp(minVertical, maxVertical).toDouble();
    
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  /// Get responsive padding with individual sides
  static EdgeInsets getResponsivePaddingLTRB(
    BuildContext context, {
    double leftPercentage = 0.04,
    double topPercentage = 0.015,
    double rightPercentage = 0.04,
    double bottomPercentage = 0.015,
    double minLeft = 16.0,
    double maxLeft = 24.0,
    double minTop = 8.0,
    double maxTop = 16.0,
    double minRight = 16.0,
    double maxRight = 24.0,
    double minBottom = 8.0,
    double maxBottom = 16.0,
  }) {
    final size = MediaQuery.of(context).size;
    double left = size.width * leftPercentage;
    double top = size.height * topPercentage;
    double right = size.width * rightPercentage;
    double bottom = size.height * bottomPercentage;
    
    // Clamp values to min/max
    left = left.clamp(minLeft, maxLeft).toDouble();
    top = top.clamp(minTop, maxTop).toDouble();
    right = right.clamp(minRight, maxRight).toDouble();
    bottom = bottom.clamp(minBottom, maxBottom).toDouble();
    
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  /// Get responsive spacing based on screen height
  static double getResponsiveSpacing(
    BuildContext context,
    double percentage,
    double minSpacing,
    double maxSpacing,
  ) {
    final height = MediaQuery.of(context).size.height;
    double spacing = height * percentage;
    return spacing.clamp(minSpacing, maxSpacing).toDouble();
  }

  /// Get responsive font size based on screen dimensions
  static double getResponsiveFontSize(
    BuildContext context,
    double percentage,
    double minSize,
    double maxSize,
  ) {
    final height = MediaQuery.of(context).size.height;
    double fontSize = height * percentage;
    return fontSize.clamp(minSize, maxSize).toDouble();
  }

  /// Get responsive dimension based on screen width
  static double getResponsiveWidth(
    BuildContext context,
    double percentage,
    double minSize,
    double maxSize,
  ) {
    final width = MediaQuery.of(context).size.width;
    double dimension = width * percentage;
    return dimension.clamp(minSize, maxSize).toDouble();
  }

  /// Get responsive dimension based on screen height
  static double getResponsiveHeight(
    BuildContext context,
    double percentage,
    double minSize,
    double maxSize,
  ) {
    final height = MediaQuery.of(context).size.height;
    double dimension = height * percentage;
    return dimension.clamp(minSize, maxSize).toDouble();
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(
    BuildContext context,
    double percentage,
    double minSize,
    double maxSize,
  ) {
    final height = MediaQuery.of(context).size.height;
    double iconSize = height * percentage;
    return iconSize.clamp(minSize, maxSize).toDouble();
  }

  /// Get responsive container size
  static Size getResponsiveContainerSize(
    BuildContext context, {
    double widthPercentage = 0.25,
    double heightPercentage = 0.25,
    double minWidth = 80.0,
    double maxWidth = 150.0,
    double minHeight = 80.0,
    double maxHeight = 150.0,
  }) {
    final size = MediaQuery.of(context).size;
    double width = size.width * widthPercentage;
    double height = size.height * heightPercentage;
    
    width = width.clamp(minWidth, maxWidth).toDouble();
    height = height.clamp(minHeight, maxHeight).toDouble();
    
    return Size(width, height);
  }

  /// Get responsive button height
  static double getResponsiveButtonHeight(
    BuildContext context,
    double percentage,
    double minSize,
    double maxSize,
  ) {
    final height = MediaQuery.of(context).size.height;
    double buttonHeight = height * percentage;
    return buttonHeight.clamp(minSize, maxSize).toDouble();
  }

  /// Get responsive aspect ratio for containers
  static double getResponsiveAspectRatio(
    BuildContext context,
    double baseRatio,
    double minRatio,
    double maxRatio,
  ) {
    final size = MediaQuery.of(context).size;
    double ratio = baseRatio;
    
    // Adjust aspect ratio based on screen dimensions
    if (size.width < 400) {
      ratio = baseRatio * 1.2; // Wider for narrow screens
    } else if (size.width > 800) {
      ratio = baseRatio * 0.9; // Narrower for wide screens
    }
    
    return ratio.clamp(minRatio, maxRatio).toDouble();
  }

  /// Check if screen is considered large (width > 600)
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  /// Check if screen is considered medium (width > 400 and <= 600)
  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 400 && width <= 600;
  }

  /// Check if screen is considered small (width <= 400)
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= 400;
  }
}