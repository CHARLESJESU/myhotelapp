import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../language/language_controller.dart';

/// Menu category chip widget
class MenuCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color buttonBg;
  final Color cardBg;
  final Color secondaryText;

  const MenuCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.buttonBg,
    required this.cardBg,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isSelected ? buttonBg : cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? AppColors.buttonText
              : secondaryText,
        ),
      ),
    );
  }
}

/// Menu item card widget
class MenuItemCard extends StatelessWidget {
  final int index;
  final bool hasCount;
  final int count;
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;
  final Color buttonBg;
  final VoidCallback onAdd;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MenuItemCard({
    super.key,
    required this.index,
    required this.hasCount,
    required this.count,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
    required this.buttonBg,
    required this.onAdd,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
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
                      Get.find<LanguageController>().tr('margherita_pizza'),
                      style: TextStyle(
                        color: primaryText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      Get.find<LanguageController>().tr('price_margherita'),
                      style: TextStyle(color: secondaryText),
                    ),
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
                ? QuantityControls(
                    count: count,
                    buttonBg: buttonBg,
                    onIncrement: onIncrement,
                    onDecrement: onDecrement,
                  )
                : AddButton(buttonBg: buttonBg, onTap: onAdd),
          ),
        ],
      ),
    );
  }
}

/// Quantity controls widget
class QuantityControls extends StatelessWidget {
  final int count;
  final Color buttonBg;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityControls({
    super.key,
    required this.count,
    required this.buttonBg,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: buttonBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onDecrement,
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
            onTap: onIncrement,
            child: const Icon(
              Icons.add,
              color: AppColors.buttonText,
            ),
          ),
        ],
      ),
    );
  }
}

/// Add button widget
class AddButton extends StatelessWidget {
  final Color buttonBg;
  final VoidCallback onTap;

  const AddButton({
    super.key,
    required this.buttonBg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: buttonBg,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: AppColors.buttonText),
      ),
    );
  }
}
