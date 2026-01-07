import 'package:flutter/material.dart';

// Screen imports
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
import '../screens/confirm_order_dialog/confirm_order_dialog_ui.dart';

/// App route names
class AppRoutes {
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
  static const String confirmOrderDialog = '/confirm-order-dialog';
}

/// App router for navigation
class AppRouter {
  /// Generate routes for the app
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _buildRoute(const HomeScreen(), settings);

      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings);

      case AppRoutes.signUp:
        return _buildRoute(const SignUpScreen(), settings);

      case AppRoutes.forgotPassword:
        return _buildRoute(const ForgotPasswordScreen(), settings);

      case AppRoutes.menu:
        return _buildRoute(const MenuScreen(), settings);

      case AppRoutes.cart:
        return _buildRoute(const CartScreen(), settings);

      case AppRoutes.favorites:
        return _buildRoute(const FavoritesScreen(), settings);

      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen(), settings);

      case AppRoutes.addRecipe:
        return _buildRoute(const AddRecipeScreen(), settings);

      case AppRoutes.trackOrder:
        return _buildRoute(const TrackOrderScreen(), settings);

      case AppRoutes.orderHistory:
        return _buildRoute(const OrderHistoryScreen(), settings);

      case AppRoutes.adminOrderManagement:
        return _buildRoute(const AdminOrderManagementScreen(), settings);

      case AppRoutes.confirmOrderDialog:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          ConfirmOrderDialog(
            items: args?['items'] ?? [],
            deliveryFee: args?['deliveryFee'] ?? 0.0,
            taxes: args?['taxes'] ?? 0.0,
          ),
          settings,
        );

      default:
        return _buildRoute(const LoginScreen(), settings);
    }
  }

  /// Build a MaterialPageRoute
  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }

  /// Navigate to a named route
  static Future<T?> navigateTo<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  /// Navigate and replace current route
  static Future<T?> navigateAndReplace<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed<T, dynamic>(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate and remove all previous routes
  static Future<T?> navigateAndRemoveUntil<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Go back to previous screen
  static void goBack<T>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }

  /// Check if can go back
  static bool canGoBack(BuildContext context) {
    return Navigator.canPop(context);
  }
}
