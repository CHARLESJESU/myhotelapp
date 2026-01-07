import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/primary_button.dart';
import 'menu_dummydata.dart';
import 'widget/menu_widget.dart';

/// Full MenuScreen with Scaffold and AppBar (for direct navigation)
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

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
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: colors.primaryText),
          ),
        ],
      ),
      body: const SafeArea(child: MenuContent()),
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
    final categories = MenuDummyData.categories;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title for bottom nav version
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Menu',
              style: TextStyle(
                color: colors.primaryText,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
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
          ),

          // sticky preview order bar
          Padding(
            padding: const EdgeInsets.only(top: 12),
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
    );
  }
}
