import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../../services/auth_service.dart';
import '../../../language/language_controller.dart';
import '../../router/routing.dart';
import 'home_dummydata.dart';
import 'widget/home_widget.dart';

/// Full HomeScreen with Scaffold (for direct navigation)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Record that the user is on the home screen
    _recordScreenVisit();
  }

  void _recordScreenVisit() async {
    final authService = Get.find<AuthService>();

  }

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

    // Get responsive values
    final padding = ResponsiveHelper.getResponsivePaddingLTRB(
      context,
      leftPercentage: 0.04,
      topPercentage: 0.015,
      rightPercentage: 0.04,
      bottomPercentage: 0.01,
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
    final largeSpacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      0.02,
      16,
      24,
    );
    final greetingFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.03,
      20,
      28,
    );
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      18,
      22,
    );
    final promoHeight = ResponsiveHelper.getResponsiveHeight(
      context,
      0.15,
      120,
      180,
    );
    final dishCardHeight = ResponsiveHelper.getResponsiveHeight(
      context,
      0.15,
      120,
      160,
    );
    final categoryChipHeight = ResponsiveHelper.getResponsiveHeight(
      context,
      0.06,
      40,
      50,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding.left, padding.top, padding.right, padding.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // top row: location and avatar
            Row(
              children: [
                Icon(Icons.place, color: colors.secondaryText),
                SizedBox(width: smallSpacing),
                Expanded(
                  child: Text(
                    Get.find<LanguageController>().tr('delivering_to_home'),
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

            SizedBox(height: smallSpacing),

            // greeting
            Text(
              Get.find<LanguageController>().tr('good_morning'),
              style: TextStyle(
                color: colors.primaryText,
                fontSize: greetingFontSize,
                fontWeight: FontWeight.w800,
              ),
            ),

            SizedBox(height: smallSpacing),

            // search bar
            HomeSearchBar(
              inputBg: colors.inputBackground,
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
            ),

            SizedBox(height: smallSpacing),

            // promo carousel (simple PageView)
            SizedBox(
              height: promoHeight,
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

            SizedBox(height: smallSpacing),

            // category chips
            SizedBox(
              height: categoryChipHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) =>
                    SizedBox(width: smallSpacing),
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

            SizedBox(height: mediumSpacing),

            // Featured Dishes horizontal list
            Text(
              Get.find<LanguageController>().tr('featured_dishes'),
              style: TextStyle(
                color: colors.primaryText,
                fontWeight: FontWeight.w700,
                fontSize: titleFontSize,
              ),
            ),
            SizedBox(height: smallSpacing),
            SizedBox(
              height: dishCardHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                separatorBuilder: (context, index) =>
                    SizedBox(width: mediumSpacing),
                itemBuilder: (context, i) => DishCard(
                  cardBg: colors.card,
                  primaryText: colors.primaryText,
                  secondaryText: colors.secondaryText,
                ),
              ),
            ),

            SizedBox(height: smallSpacing),

            // Restaurants list
            Text(
              Get.find<LanguageController>().tr('restaurants_near_you'),
              style: TextStyle(
                color: colors.primaryText,
                fontWeight: FontWeight.w700,
                fontSize: titleFontSize,
              ),
            ),
            SizedBox(height: smallSpacing),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) =>
                  SizedBox(height: mediumSpacing),
              itemBuilder: (context, i) => RestaurantCard(
                cardBg: colors.card,
                primaryText: colors.primaryText,
                secondaryText: colors.secondaryText,
              ),
            ),

            // Add bottom padding to account for bottom navigation
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
