import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../add_recipe/add_recipe_ui.dart';
import 'admin_order_management_dummydata.dart';
import 'widget/admin_order_management_widget.dart';

class AdminOrderManagementScreen extends StatelessWidget {
  const AdminOrderManagementScreen({super.key});

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

    final orders = AdminOrderManagementDummyData.sampleOrders;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Order Management',
            style: TextStyle(color: primaryText, fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            icon: Icon(Icons.search, color: AppColors.appBarIcon),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list, color: AppColors.appBarIcon),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: AppColors.lightBottomNavActive,
            labelColor: AppColors.lightBottomNavActive,
            unselectedLabelColor: secondaryText,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'New'),
              Tab(text: 'Preparing'),
              Tab(text: 'Delivered'),
            ],
          ),
        ),
        // centered "Add new Recipe" button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AddRecipeScreen()));
          },
          icon: Icon(Icons.add, color: AppColors.buttonText),
          label: Text(
            'Add new Recipe',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.buttonText,
            ),
          ),
          backgroundColor: isDark
              ? AppColors.buttonBg
              : AppColors.lightButtonBg,
        ),
        body: TabBarView(
          children: [
            _buildOrderList(
              context,
              orders,
              null,
              cardBg,
              primaryText,
              secondaryText,
            ),
            _buildOrderList(
              context,
              orders,
              'New',
              cardBg,
              primaryText,
              secondaryText,
            ),
            _buildOrderList(
              context,
              orders,
              'Preparing',
              cardBg,
              primaryText,
              secondaryText,
            ),
            _buildOrderList(
              context,
              orders,
              'Delivered',
              cardBg,
              primaryText,
              secondaryText,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(
    BuildContext context,
    List<OrderItem> orders,
    String? filter,
    Color cardBg,
    Color primaryText,
    Color secondaryText,
  ) {
    final list = filter == null
        ? orders
        : orders.where((o) => o.status == filter).toList();
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, idx) {
        final order = list[idx];
        return OrderCard(
          order: order,
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText,
        );
      },
    );
  }
}
