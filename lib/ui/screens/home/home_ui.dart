import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../router/routing.dart';
import 'home_dummydata.dart';
import 'widget/home_widget.dart';

/// Full HomeScreen with Scaffold (for direct navigation)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.screenBackground,
      body: const SafeArea(child: HomeContent()),
    );
  }
}

/// Home content widget (for use inside BottomRoutingScreen)
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final categories = HomeDummyData.categories;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // top row: location and avatar
          Row(
            children: [
              Icon(Icons.place, color: colors.secondaryText),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Delivering to Home',
                  style: TextStyle(
                    color: colors.secondaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.profile),
                child: CircleAvatar(
                  backgroundColor: colors.card,
                  child: Icon(Icons.person, color: colors.buttonBg),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // greeting
          Text(
            'Good morning, Alex!',
            style: TextStyle(
              color: colors.primaryText,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 12),

          // search bar
          HomeSearchBar(
            inputBg: colors.inputBackground,
            primaryText: colors.primaryText,
            secondaryText: colors.secondaryText,
          ),

          const SizedBox(height: 12),

          // promo carousel (simple PageView)
          SizedBox(
            height: 140,
            child: PageView(
              children: [
                PromoCard(
                  cardBg: colors.card,
                  primaryText: colors.primaryText,
                  secondaryText: colors.secondaryText,
                ),
                PromoCard(
                  cardBg: colors.card,
                  primaryText: colors.primaryText,
                  secondaryText: colors.secondaryText,
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
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final selected = i == _selectedCategory;
                return CategoryChip(
                  label: categories[i],
                  isSelected: selected,
                  buttonBg: colors.buttonBg,
                  inputBg: colors.inputBackground,
                  secondaryText: colors.secondaryText,
                  onTap: () => setState(() => _selectedCategory = i),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Featured Dishes horizontal list
          Text(
            'Featured Dishes',
            style: TextStyle(
              color: colors.primaryText,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, i) => DishCard(
                cardBg: colors.card,
                primaryText: colors.primaryText,
                secondaryText: colors.secondaryText,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Restaurants list
          Text(
            'Restaurants Near You',
            style: TextStyle(
              color: colors.primaryText,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, i) => RestaurantCard(
                cardBg: colors.card,
                primaryText: colors.primaryText,
                secondaryText: colors.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
