import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'order_history_dummydata.dart';
import 'widget/order_history_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  final bool isDark;
  const OrderHistoryScreen({super.key, this.isDark = true});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String filter = 'Completed'; // Completed | Cancelled
  String query = '';

  final orders = OrderHistoryDummyData.orders;

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
            OrderHistorySearchBar(
              inputBg: isDark
                  ? AppColors.inputBackground
                  : AppColors.lightInputBackground,
              primaryText: primaryText,
              secondaryText: secondaryText,
              onChanged: (v) => setState(() => query = v),
            ),

            const SizedBox(height: 12),

            // segmented control
            OrderHistoryFilterTabs(
              filter: filter,
              cardBg: cardBg,
              buttonBg: buttonBg,
              buttonText: buttonText,
              secondaryText: secondaryText,
              onFilterChanged: (newFilter) => setState(() => filter = newFilter),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, idx) {
                  final o = filtered[idx];
                  final isDelivered = o['status'] == 'Delivered';
                  return OrderHistoryCard(
                    title: o['title'] as String,
                    date: o['date'] as String,
                    summary: o['summary'] as String,
                    price: o['price'] as double,
                    isDelivered: isDelivered,
                    cardBg: cardBg,
                    primaryText: primaryText,
                    secondaryText: secondaryText,
                    buttonBg: buttonBg,
                    buttonText: buttonText,
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
