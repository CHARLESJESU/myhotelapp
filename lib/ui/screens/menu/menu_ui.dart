import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/primary_button.dart';
import 'menu_dummydata.dart';
import 'widget/menu_widget.dart';

class MenuScreen extends StatefulWidget {
  final bool isDark;
  const MenuScreen({super.key, this.isDark = true});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // simple count map to show quantity controls for some items
  final Map<int, int> _counts = {1: 1};

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
    final cardBg = isDark ? AppColors.cardDark : AppColors.lightCard;
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;

    final categories = MenuDummyData.categories;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: primaryText),
        ),
        centerTitle: true,
        title: Text(
          'Menu',
          style: TextStyle(color: primaryText, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: primaryText),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final selected = i == 0; // 'All' selected by default for UI
                    return MenuCategoryChip(
                      label: categories[i],
                      isSelected: selected,
                      buttonBg: buttonBg,
                      cardBg: cardBg,
                      secondaryText: secondaryText,
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, i) {
                    final hasCount = _counts.containsKey(i);
                    final count = _counts[i] ?? 0;
                    return MenuItemCard(
                      index: i,
                      hasCount: hasCount,
                      count: count,
                      cardBg: cardBg,
                      primaryText: primaryText,
                      secondaryText: secondaryText,
                      buttonBg: buttonBg,
                      onAdd: () => setState(() => _counts[i] = 1),
                      onIncrement: () => setState(
                        () => _counts[i] = (_counts[i] ?? 0) + 1,
                      ),
                      onDecrement: () => setState(
                        () => _counts[i] = (_counts[i] ?? 1) - 1,
                      ),
                    );
                  },
                ),
              ),

              // sticky preview order bar
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: PrimaryButton(
                  label: 'Preview Order (3 items | \$45.50)',
                  onPressed: () {},
                  backgroundColor: buttonBg,
                  textColor: AppColors.buttonText,
                  shadowColor: AppColors.buttonShadow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
