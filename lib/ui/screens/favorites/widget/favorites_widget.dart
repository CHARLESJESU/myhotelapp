import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

/// Search bar widget for favorites screen
class FavoritesSearchBar extends StatelessWidget {
  final Color inputBg;
  final Color primaryText;
  final Color secondaryText;
  final String hintText;
  final ValueChanged<String> onChanged;

  const FavoritesSearchBar({
    super.key,
    required this.inputBg,
    required this.primaryText,
    required this.secondaryText,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.secondaryText),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: TextStyle(color: primaryText),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: secondaryText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Favorite item card widget
class FavoriteCard extends StatelessWidget {
  final String title;
  final double price;
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;
  final Color buttonBg;
  final Color buttonText;

  const FavoriteCard({
    super.key,
    required this.title,
    required this.price,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
    required this.buttonBg,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.uploadPlaceholder,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFCCCCCC),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.orange,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: primaryText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: TextStyle(color: secondaryText),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: buttonBg,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add, color: buttonText),
                    onPressed: () {},
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
