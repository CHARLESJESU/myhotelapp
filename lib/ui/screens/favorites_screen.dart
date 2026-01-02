import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class FavoritesScreen extends StatefulWidget {
  final bool isDark;
  const FavoritesScreen({super.key, this.isDark = true});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final items = [
    {'title': 'Pepperoni Pizza', 'price': 12.50},
    {'title': 'Quinoa Salad', 'price': 9.00},
    {'title': 'Classic Burger', 'price': 10.99},
    {'title': 'Tonkotsu Ramen', 'price': 14.25},
    {'title': 'Pasta Bolognese', 'price': 13.50},
    {'title': 'Sushi Platter', 'price': 22.00},
  ];

  String _query = '';

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
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;

    final filtered = items
        .where(
          (it) => (it['title'] as String).toLowerCase().contains(
            _query.toLowerCase(),
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Favorites',
          style: TextStyle(color: primaryText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(color: buttonBg, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            // search
            Container(
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
                      onChanged: (v) => setState(() => _query = v),
                      style: TextStyle(color: primaryText),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search in favorites...',
                        hintStyle: TextStyle(color: secondaryText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: filtered.length,
                itemBuilder: (context, idx) {
                  final it = filtered[idx];
                  return _favCard(
                    it['title'] as String,
                    it['price'] as double,
                    cardBg,
                    primaryText,
                    secondaryText,
                    buttonBg,
                    buttonText,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _favCard(
    String title,
    double price,
    Color bg,
    Color primaryText,
    Color secondaryText,
    Color btnBg,
    Color btnText,
  ) => Container(
    decoration: BoxDecoration(
      color: bg,
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
                  color: btnBg,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.add, color: btnText),
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
