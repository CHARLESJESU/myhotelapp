import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final colors = context.colors;

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
      backgroundColor: colors.screenBackground,
      appBar: AppBar(
        backgroundColor: colors.screenBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.primaryText),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Order History',
          style: TextStyle(color: colors.primaryText, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          children: [
            OrderHistorySearchBar(
              inputBg: colors.inputBackground,
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
              onChanged: (v) => setState(() => query = v),
            ),

            const SizedBox(height: 12),

            // segmented control
            OrderHistoryFilterTabs(
              filter: filter,
              cardBg: colors.card,
              buttonBg: colors.buttonBg,
              buttonText: colors.buttonText,
              secondaryText: colors.secondaryText,
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
                    cardBg: colors.card,
                    primaryText: colors.primaryText,
                    secondaryText: colors.secondaryText,
                    buttonBg: colors.buttonBg,
                    buttonText: colors.buttonText,
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
