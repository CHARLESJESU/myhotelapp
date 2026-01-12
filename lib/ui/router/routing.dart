import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Screen imports
import '../screens/bottomnavroute/bottomroutingscreen.dart';
import '../screens/home/home_ui.dart';
import '../screens/login/login_ui.dart';
import '../screens/sign_up/sign_up_ui.dart';
import '../screens/forgot_password/forgot_password_ui.dart';
import '../screens/menu/menu_ui.dart';
import '../screens/cart/cart_ui.dart';
import '../screens/favorites/favorites_ui.dart';
import '../screens/profile/profile_ui.dart';
import '../screens/add_recipe/add_recipe_ui.dart';
import '../screens/track_order/track_order_ui.dart';
import '../screens/order_history/order_history_ui.dart';
import '../screens/admin_order_management/admin_order_management_ui.dart';
import '../screens/splash/splash_screen.dart';

/// App route names
class AppRoutes {
  /// Main bottom navigation screen (entry after login)
  static const String main = '/main';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String menu = '/menu';
  static const String cart = '/cart';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String addRecipe = '/add-recipe';
  static const String trackOrder = '/track-order';
  static const String orderHistory = '/order-history';
  static const String adminOrderManagement = '/admin-order-management';
  static const String splash = '/splash';
}

/// App router for GetX navigation
class AppRouter {
  /// GetX route pages
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
    // Main bottom navigation screen (entry after login)
    GetPage(
      name: AppRoutes.main,
      page: () => const BottomRoutingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUpScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.menu,
      page: () => const MenuScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.addRecipe,
      page: () => const AddRecipeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.trackOrder,
      page: () => const TrackOrderScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.orderHistory,
      page: () => const OrderHistoryScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.adminOrderManagement,
      page: () => const AdminOrderManagementScreen(),
      transition: Transition.fadeIn,
    ),
  ];

  // ─────────────────────────────────────────────────────────────────────────────
  // Navigation helpers using GetX
  // ─────────────────────────────────────────────────────────────────────────────

  /// Navigate to a named route
  static Future<T?>? to<T>(String routeName, {dynamic arguments}) {
    return Get.toNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate and replace current route
  static Future<T?>? off<T>(String routeName, {dynamic arguments}) {
    return Get.offNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate and remove all previous routes
  static Future<T?>? offAll<T>(String routeName, {dynamic arguments}) {
    return Get.offAllNamed<T>(routeName, arguments: arguments);
  }

  /// Go back to previous screen
  static void back<T>([T? result]) {
    Get.back<T>(result: result);
  }

  /// Show a dialog using GetX
  static Future<T?> dialog<T>(
    Widget dialog, {
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return Get.dialog<T>(
      dialog,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
    );
  }

  /// Show a snackbar using GetX
  static void snackbar(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
    Color? backgroundColor,
    Color? colorText,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: colorText,
    );
  }

  /// Show a bottom sheet using GetX
  static Future<T?> bottomSheet<T>(
    Widget bottomSheet, {
    bool isDismissible = true,
    Color? backgroundColor,
  }) {
    return Get.bottomSheet<T>(
      bottomSheet,
      isDismissible: isDismissible,
      backgroundColor: backgroundColor,
    );
  }
}
