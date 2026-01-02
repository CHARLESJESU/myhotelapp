import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'menu_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

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

    final categories = ['Pizza', 'Sushi', 'Burgers', 'Desserts', 'Drinks'];

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
              Container(
                decoration: BoxDecoration(
                  color: inputBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.secondaryText),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: primaryText),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Find restaurants or dishes',
                          hintStyle: TextStyle(color: secondaryText),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // promo carousel (simple PageView)
              SizedBox(
                height: 140,
                child: PageView(
                  children: [
                    _promoCard(cardBg, primaryText, secondaryText),
                    _promoCard(cardBg, primaryText, secondaryText),
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
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? buttonBg : inputBg,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_pizza,
                              color: selected
                                  ? AppColors.buttonText
                                  : AppColors.secondaryText,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              categories[i],
                              style: TextStyle(
                                color: selected
                                    ? AppColors.buttonText
                                    : secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      _dishCard(cardBg, primaryText, secondaryText),
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
                      _restaurantCard(cardBg, primaryText, secondaryText),
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

  Widget _promoCard(Color cardBg, Color primaryText, Color secondaryText) =>
      Card(
        color: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '50% OFF Your First Order',
                      style: TextStyle(
                        color: primaryText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Valid for new users only',
                      style: TextStyle(color: secondaryText),
                    ),
                  ],
                ),
              ),
              Container(width: 120, color: AppColors.uploadPlaceholder),
            ],
          ),
        ),
      );

  Widget _dishCard(Color cardBg, Color primaryText, Color secondaryText) =>
      Container(
        width: 180,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: AppColors.uploadPlaceholder,
                ),
                child: const Center(
                  child: Icon(
                    Icons.restaurant,
                    color: AppColors.buttonBg,
                    size: 36,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spicy Pizza',
                    style: TextStyle(
                      color: primaryText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Pizzeria Roma',
                    style: TextStyle(color: secondaryText, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$14.99',
                    style: TextStyle(
                      color: primaryText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _restaurantCard(
    Color cardBg,
    Color primaryText,
    Color secondaryText,
  ) => Container(
    height: 84,
    decoration: BoxDecoration(
      color: cardBg,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: AppColors.uploadPlaceholder,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'The Gourmet Kitchen',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Italian • \$\$',
                style: TextStyle(color: secondaryText, fontSize: 12),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 14),
                SizedBox(width: 4),
                Text('4.8', style: TextStyle(color: AppColors.primaryText)),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '25-35 min',
              style: TextStyle(color: secondaryText, fontSize: 12),
            ),
          ],
        ),
      ],
    ),
  );
}
