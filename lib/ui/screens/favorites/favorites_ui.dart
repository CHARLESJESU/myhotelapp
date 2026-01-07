import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import 'favorites_dummydata.dart';
import 'widget/favorites_widget.dart';

/// Full FavoritesScreen with Scaffold and AppBar (for direct navigation)
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.screenBackground,
      appBar: AppBar(
        backgroundColor: colors.screenBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.primaryText),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Favorites',
          style: TextStyle(
            color: colors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Edit',
              style: TextStyle(
                color: colors.buttonBg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: const SafeArea(child: FavoritesContent()),
    );
  }
}

/// Favorites content widget (for use inside BottomRoutingScreen)
class FavoritesContent extends StatefulWidget {
  const FavoritesContent({super.key});

  @override
  State<FavoritesContent> createState() => _FavoritesContentState();
}

class _FavoritesContentState extends State<FavoritesContent> {
  final List<Map<String, dynamic>> _items = FavoritesDummyData.favoriteItems;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final filtered = _items
        .where(
          (it) => (it['title'] as String).toLowerCase().contains(
            _query.toLowerCase(),
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title row for bottom nav version
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Favorites',
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: colors.buttonBg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

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
    );
  }
}
