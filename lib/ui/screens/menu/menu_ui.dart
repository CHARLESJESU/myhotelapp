import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
import '../../widgets/primary_button.dart';
import 'menu_dummydata.dart';
import 'widget/menu_widget.dart';

/// Full MenuScreen with Scaffold and AppBar (for direct navigation)
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: colors.primaryText),
        ),
        centerTitle: true,
        title: Text(
          'Menu',
          style: TextStyle(
            color: colors.primaryText,
            fontWeight: FontWeight.w700,
            fontSize: titleFontSize,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: colors.primaryText),
          ),
        ],
      ),
      body: SafeArea(child: MenuContent()),
    );
  }
}

/// Menu content widget (for use inside BottomRoutingScreen)
class MenuContent extends StatefulWidget {
  const MenuContent({super.key});

  @override
  State<MenuContent> createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  final Map<int, int> _counts = {1: 1};

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final responsive = ResponsiveHelper;
    final categories = MenuDummyData.categories;

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
    final categoryChipHeight = ResponsiveHelper.getResponsiveHeight(
      context,
      0.06,
      40,
      50,
    );

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
            // Title for bottom nav version
            Padding(
              padding: EdgeInsets.only(bottom: mediumSpacing),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: colors.primaryText,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            SizedBox(
              height: categoryChipHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) =>
                    SizedBox(width: smallSpacing),
                itemBuilder: (context, i) {
                  final selected = i == 0;
                  return MenuCategoryChip(
                    label: categories[i],
                    isSelected: selected,
                    buttonBg: colors.buttonBg,
                    cardBg: colors.card,
                    secondaryText: colors.secondaryText,
                  );
                },
              ),
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
                  0.78,
                  0.6,
                  1.0,
                ),
              ),
              itemCount: 8,
              itemBuilder: (context, i) {
                final hasCount = _counts.containsKey(i);
                final count = _counts[i] ?? 0;
                return MenuItemCard(
                  index: i,
                  hasCount: hasCount,
                  count: count,
                  cardBg: colors.card,
                  primaryText: colors.primaryText,
                  secondaryText: colors.secondaryText,
                  buttonBg: colors.buttonBg,
                  onAdd: () => setState(() => _counts[i] = 1),
                  onIncrement: () =>
                      setState(() => _counts[i] = (_counts[i] ?? 0) + 1),
                  onDecrement: () =>
                      setState(() => _counts[i] = (_counts[i] ?? 1) - 1),
                );
              },
            ),

            // sticky preview order bar
            Padding(
              padding: EdgeInsets.only(top: mediumSpacing),
              child: PrimaryButton(
                label: 'Preview Order (3 items | \$45.50)',
                onPressed: () {},
                backgroundColor: colors.buttonBg,
                textColor: colors.buttonText,
                shadowColor: colors.buttonShadow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
