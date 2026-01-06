import 'package:flutter/material.dart';
import '../../../../constants/app_colors.dart';

/// Search bar widget for order history
class OrderHistorySearchBar extends StatelessWidget {
  final Color inputBg;
  final Color primaryText;
  final Color secondaryText;
  final ValueChanged<String> onChanged;

  const OrderHistorySearchBar({
    super.key,
    required this.inputBg,
    required this.primaryText,
    required this.secondaryText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.secondaryText),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: TextStyle(color: primaryText),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search by restaurant or item',
                hintStyle: TextStyle(color: secondaryText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Filter tabs widget for order history
class OrderHistoryFilterTabs extends StatelessWidget {
  final String filter;
  final Color cardBg;
  final Color buttonBg;
  final Color buttonText;
  final Color secondaryText;
  final ValueChanged<String> onFilterChanged;

  const OrderHistoryFilterTabs({
    super.key,
    required this.filter,
    required this.cardBg,
    required this.buttonBg,
    required this.buttonText,
    required this.secondaryText,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onFilterChanged('Completed'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: filter == 'Completed'
                      ? buttonBg
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      color: filter == 'Completed'
                          ? buttonText
                          : secondaryText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => onFilterChanged('Cancelled'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: filter == 'Cancelled'
                      ? Colors.red.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Cancelled',
                    style: TextStyle(
                      color: filter == 'Cancelled'
                          ? Colors.red
                          : secondaryText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Order history card widget
class OrderHistoryCard extends StatelessWidget {
  final String title;
  final String date;
  final String summary;
  final double price;
  final bool isDelivered;
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;
  final Color buttonBg;
  final Color buttonText;

  const OrderHistoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.summary,
    required this.price,
    required this.isDelivered,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
    required this.buttonBg,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.uploadPlaceholder,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: primaryText,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      date,
                      style: TextStyle(color: secondaryText),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDelivered ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isDelivered ? 'Delivered' : 'Cancelled',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            summary,
            style: TextStyle(color: secondaryText),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.cardDark,
                  foregroundColor: AppColors.primaryText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text('View Details'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBg,
                  foregroundColor: buttonText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  isDelivered ? 'Reorder' : 'Order Again',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Status badge widget
class StatusBadge extends StatelessWidget {
  final bool isDelivered;

  const StatusBadge({super.key, required this.isDelivered});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDelivered ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isDelivered ? 'Delivered' : 'Cancelled',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
