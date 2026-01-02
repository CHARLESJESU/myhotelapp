import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class OrderHistoryScreen extends StatefulWidget {
  final bool isDark;
  const OrderHistoryScreen({super.key, this.isDark = true});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String filter = 'Completed'; // Completed | Cancelled
  String query = '';

  final orders = [
    {
      'title': 'The Pizza Place',
      'date': 'October 26, 2023',
      'summary': 'Pepperoni Pizza, Garlic Bread, and 1 more item',
      'price': 34.50,
      'status': 'Delivered',
    },
    {
      'title': 'Sushi Express',
      'date': 'October 22, 2023',
      'summary': 'California Roll, Spicy Tuna Roll, and 2 more items',
      'price': 45.80,
      'status': 'Delivered',
    },
    {
      'title': 'Burger Joint',
      'date': 'October 19, 2023',
      'summary': 'Classic Burger, French Fries',
      'price': 18.20,
      'status': 'Cancelled',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? AppColors.screenBackground
        : AppColors.lightScreenBackground;
    final cardBg = isDark ? AppColors.cardDark : AppColors.lightCard;
    final primaryText = isDark
        ? AppColors.primaryText
        : AppColors.lightPrimaryText;
    final secondaryText = isDark
        ? AppColors.secondaryText
        : AppColors.lightSecondaryText;
    final buttonBg = isDark ? AppColors.buttonBg : AppColors.lightButtonBg;
    final buttonText = isDark
        ? AppColors.buttonText
        : AppColors.lightButtonText;

    final filtered = orders
        .where(
          (o) =>
              (filter == 'Completed'
                  ? o['status'] != 'Cancelled'
                  : o['status'] == 'Cancelled') &&
              (query.isEmpty ||
                  (o['title'] as String).toLowerCase().contains(
                    query.toLowerCase(),
                  )),
        )
        .toList();

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Order History',
          style: TextStyle(color: primaryText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.inputBackground
                    : AppColors.lightInputBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.secondaryText),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (v) => setState(() => query = v),
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
            ),

            const SizedBox(height: 12),

            // segmented control
            Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(6),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => filter = 'Completed'),
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
                      onTap: () => setState(() => filter = 'Cancelled'),
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
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, idx) {
                  final o = filtered[idx];
                  final isDelivered = o['status'] == 'Delivered';
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
                                    o['title'] as String,
                                    style: TextStyle(
                                      color: primaryText,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    o['date'] as String,
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
                          o['summary'] as String,
                          style: TextStyle(color: secondaryText),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              '\$${(o['price'] as double).toStringAsFixed(2)}',
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
