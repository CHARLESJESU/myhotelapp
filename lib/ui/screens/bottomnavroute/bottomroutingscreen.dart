import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../language/language_controller.dart';
import '../home/home_ui.dart';
import '../menu/menu_ui.dart';
import '../cart/cart_ui.dart';
import '../favorites/favorites_ui.dart';

/// Main bottom navigation routing screen.
/// This is the entry point after login - all main screens are accessed from here.
class BottomRoutingScreen extends StatefulWidget {
  final int initialIndex;

  const BottomRoutingScreen({super.key, this.initialIndex = 0});

  @override
  State<BottomRoutingScreen> createState() => _BottomRoutingScreenState();
}

class _BottomRoutingScreenState extends State<BottomRoutingScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    // Record that the user is on the main screen
  
  }



  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.screenBackground,

      // IMPORTANT: Do NOT use extendBody for BottomNavigationBar
      extendBody: false,

      body: SafeArea(child: _getScreenWidget(_currentIndex)),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: colors.screenBackground,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colors.bottomNavActive,
        unselectedItemColor: colors.bottomNavInactive,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Get.find<LanguageController>().tr('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: Get.find<LanguageController>().tr('orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: Get.find<LanguageController>().tr('cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: Get.find<LanguageController>().tr('favorites'),
          ),
        ],
      ),
    );
  }

  Widget _getScreenWidget(int index) {
    switch (index) {
      case 0:
        return const HomeContent();
      case 1:
        return const MenuContent();
      case 2:
        return const CartContent();
      case 3:
        return const FavoritesContent();
      default:
        return const HomeContent();
    }
  }
}
