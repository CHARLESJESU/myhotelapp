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
    final colors = context.colors;

    final filtered = items
        .where(
          (it) => (it['title'] as String).toLowerCase().contains(
            _query.toLowerCase(),
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: colors.screenBackground,
      appBar: AppBar(
        backgroundColor: colors.screenBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Favorites',
          style: TextStyle(color: colors.primaryText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(color: colors.buttonBg, fontWeight: FontWeight.w600),
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
              inputBg: colors.inputBackground,
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
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
                    cardBg: colors.card,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                    buttonBg: colors.buttonBg,
                    buttonText: colors.buttonText,
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
