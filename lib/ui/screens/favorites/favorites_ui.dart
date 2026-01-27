import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../language/language_controller.dart';
import 'favorites_dummydata.dart';
import 'widget/favorites_widget.dart';

/// Full FavoritesScreen with Scaffold and AppBar (for direct navigation)
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Get responsive values
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      16,
      20,
    );

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
          Get.find<LanguageController>().tr('favorites'),
          style: TextStyle(
            color: colors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              Get.find<LanguageController>().tr('edit'),
              style: TextStyle(
                color: colors.buttonBg,
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveHelper.getResponsiveFontSize(
                  context,
                  0.02,
                  14,
                  16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child: FavoritesContent()),
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
  late List<Map<String, dynamic>> _items;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _initializeItems();
  }

  void _initializeItems() {
    final langController = Get.find<LanguageController>();
    _items = FavoritesDummyData.favoriteItemKeys.map((item) {
      return {
        'title': langController.tr(item['title_key']),
        'price': item['price'],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Get responsive values
    final padding = ResponsiveHelper.getResponsivePaddingLTRB(
      context,
      leftPercentage: 0.04,
      topPercentage: 0.01,
      rightPercentage: 0.04,
      bottomPercentage: 0.02,
    );

    final smallSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.01,
      8,
      12,
    );
    final mediumSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.015,
      12,
      16,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.03,
      20,
      28,
    );
    final editFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.02,
      14,
      16,
    );

    final filtered = _items
        .where(
          (it) => (it['title'] as String).toLowerCase().contains(
            _query.toLowerCase(),
          ),
        )
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          padding.left,
          padding.top,
          padding.right,
          padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title row for bottom nav version
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Get.find<LanguageController>().tr('favorites'),
                  style: TextStyle(
                    color: colors.primaryText,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    Get.find<LanguageController>().tr('edit'),
                    style: TextStyle(
                      color: colors.buttonBg,
                      fontWeight: FontWeight.w600,
                      fontSize: editFontSize,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: mediumSpacing),

            // search
            FavoritesSearchBar(
              inputBg: colors.inputBackground,
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
              hintText: Get.find<LanguageController>().tr('search_in_favorites'),
              onChanged: (v) => setState(() => _query = v),
            ),
            SizedBox(height: mediumSpacing),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  0.02,
                  10,
                  16,
                ),
                mainAxisSpacing: ResponsiveHelper.getResponsiveSpacing(
                  context,
                  0.02,
                  10,
                  16,
                ),
                childAspectRatio: ResponsiveHelper.getResponsiveAspectRatio(
                  context,
                  0.75,
                  0.6,
                  1.0,
                ),
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
          ],
        ),
      ),
    );
  }
}
