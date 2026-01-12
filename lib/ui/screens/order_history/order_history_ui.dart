import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';
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

    // Get responsive values
    final padding = ResponsiveHelper.getResponsivePaddingLTRB(
      context,
      leftPercentage: 0.04,
      topPercentage: 0.015,
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
      0.025,
      18,
      22,
    );

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
          style: TextStyle(
            color: colors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          padding.left,
          padding.top,
          padding.right,
          padding.bottom,
        ),
        child: Column(
          children: [
            OrderHistorySearchBar(
              inputBg: colors.inputBackground,
              primaryText: colors.primaryText,
              secondaryText: colors.secondaryText,
              onChanged: (v) => setState(() => query = v),
            ),

            SizedBox(height: mediumSpacing),

            // segmented control
            OrderHistoryFilterTabs(
              filter: filter,
              cardBg: colors.card,
              buttonBg: colors.buttonBg,
              buttonText: colors.buttonText,
              secondaryText: colors.secondaryText,
              onFilterChanged: (newFilter) =>
                  setState(() => filter = newFilter),
            ),

            SizedBox(height: mediumSpacing),

            Expanded(
              child: ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => SizedBox(height: mediumSpacing),
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
