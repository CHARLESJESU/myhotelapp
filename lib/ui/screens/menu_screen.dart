import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../widgets/primary_button.dart';

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

    final categories = ['All', 'Pizza', 'Pasta', 'Salads', 'Drinks'];

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
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? buttonBg : cardBg,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        categories[i],
                        style: TextStyle(
                          color: selected
                              ? AppColors.buttonText
                              : secondaryText,
                        ),
                      ),
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
                    return _menuItemCard(
                      i,
                      hasCount,
                      count,
                      cardBg,
                      primaryText,
                      secondaryText,
                      buttonBg,
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

  Widget _menuItemCard(
    int i,
    bool hasCount,
    int count,
    Color cardBg,
    Color primaryText,
    Color secondaryText,
    Color buttonBg,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Container(
                    color: AppColors.uploadPlaceholder,
                    child: const Center(
                      child: Icon(
                        Icons.fastfood,
                        color: AppColors.buttonBg,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Margherita Pizza',
                      style: TextStyle(
                        color: primaryText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('\$12.99', style: TextStyle(color: secondaryText)),
                  ],
                ),
              ),
            ],
          ),

          // bottom-right floating add / qty controls
          Positioned(
            right: 8,
            top: 8,
            child: hasCount
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: buttonBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(
                            () => _counts[i] = (_counts[i] ?? 1) - 1,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: AppColors.buttonText,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$count',
                          style: const TextStyle(color: AppColors.buttonText),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(
                            () => _counts[i] = (_counts[i] ?? 0) + 1,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.buttonText,
                          ),
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () => setState(() => _counts[i] = 1),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: buttonBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: AppColors.buttonText),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
