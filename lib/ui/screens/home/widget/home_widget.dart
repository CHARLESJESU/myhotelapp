import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

/// Search bar widget for home screen
class HomeSearchBar extends StatelessWidget {
  final Color inputBg;
  final Color primaryText;
  final Color secondaryText;

  const HomeSearchBar({
    super.key,
    required this.inputBg,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

/// Promo card widget for carousel
class PromoCard extends StatelessWidget {
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;

  const PromoCard({
    super.key,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
  }
}

/// Category chip widget
class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color buttonBg;
  final Color inputBg;
  final Color secondaryText;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.buttonBg,
    required this.inputBg,
    required this.secondaryText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? buttonBg : inputBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(
              Icons.local_pizza,
              color: isSelected
                  ? AppColors.buttonText
                  : AppColors.secondaryText,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppColors.buttonText
                    : secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dish card widget for featured dishes
class DishCard extends StatelessWidget {
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;

  const DishCard({
    super.key,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}

/// Restaurant card widget
class RestaurantCard extends StatelessWidget {
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;

  const RestaurantCard({
    super.key,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
}
