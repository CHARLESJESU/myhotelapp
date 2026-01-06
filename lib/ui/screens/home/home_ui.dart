import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../menu/menu_ui.dart';
import '../cart/cart_ui.dart';
import '../favorites/favorites_ui.dart';
import '../profile/profile_ui.dart';
import 'home_dummydata.dart';
import 'widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  final bool isDark;
  const HomeScreen({super.key, this.isDark = true});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomIndex = 0;
  int _selectedCategory = 0;

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
    final inputBg = isDark
        ? AppColors.inputBackground
        : AppColors.lightInputBackground;
    final cardBg = isDark ? AppColors.cardDark : AppColors.lightCard;
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;

    final categories = HomeDummyData.categories;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // top row: location and avatar
              Row(
                children: [
                  const Icon(Icons.place, color: AppColors.lightPrimaryText),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Delivering to Home',
                      style: TextStyle(
                        color: secondaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => ProfileScreen())),
                    child: CircleAvatar(
                      backgroundColor: cardBg,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.buttonBg,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // greeting
              Text(
                'Good morning, Alex!',
                style: TextStyle(
                  color: primaryText,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              // search bar
              HomeSearchBar(
                inputBg: inputBg,
                primaryText: primaryText,
                secondaryText: secondaryText,
              ),

              const SizedBox(height: 12),

              // promo carousel (simple PageView)
              SizedBox(
                height: 140,
                child: PageView(
                  children: [
                    PromoCard(
                      cardBg: cardBg,
                      primaryText: primaryText,
                      secondaryText: secondaryText,
                    ),
                    PromoCard(
                      cardBg: cardBg,
                      primaryText: primaryText,
                      secondaryText: secondaryText,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // category chips
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final selected = i == _selectedCategory;
                    return CategoryChip(
                      label: categories[i],
                      isSelected: selected,
                      buttonBg: buttonBg,
                      inputBg: inputBg,
                      secondaryText: secondaryText,
                      onTap: () => setState(() => _selectedCategory = i),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Featured Dishes horizontal list
              const Text(
                'Featured Dishes',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, i) =>
                      DishCard(
                        cardBg: cardBg,
                        primaryText: primaryText,
                        secondaryText: secondaryText,
                      ),
                ),
              ),

              const SizedBox(height: 12),

              // Restaurants list
              const Text(
                'Restaurants Near You',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, i) =>
                      RestaurantCard(
                        cardBg: cardBg,
                        primaryText: primaryText,
                        secondaryText: secondaryText,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomIndex,
        onTap: (i) {
          if (i == 1) {
            // Orders tapped -> open Menu screen
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => MenuScreen()));
            return;
          }
          if (i == 2) {
            // Cart tapped -> open Cart screen
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => CartScreen()));
            return;
          }
          if (i == 3) {
            // Favorites tapped -> open Favorites screen
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => FavoritesScreen()));
            return;
          }
          setState(() => _bottomIndex = i);
        },
        backgroundColor: bg,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: buttonBg,
        unselectedItemColor: secondaryText,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
