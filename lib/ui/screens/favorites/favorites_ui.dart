import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'favorites_dummydata.dart';
import 'widget/favorites_widget.dart';

class FavoritesScreen extends StatefulWidget {
  final bool isDark;
  const FavoritesScreen({super.key, this.isDark = true});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final items = FavoritesDummyData.favoriteItems;
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
            FavoritesSearchBar(
              inputBg: inputBg,
              primaryText: primaryText,
              secondaryText: secondaryText,
              hintText: 'Search in favorites...',
              onChanged: (v) => setState(() => _query = v),
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
                  return FavoriteCard(
                    title: it['title'] as String,
                    price: it['price'] as double,
                    cardBg: cardBg,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                    buttonBg: buttonBg,
                    buttonText: buttonText,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
