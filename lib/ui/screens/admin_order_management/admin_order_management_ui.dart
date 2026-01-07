import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../add_recipe/add_recipe_ui.dart';
import 'admin_order_management_dummydata.dart';
import 'widget/admin_order_management_widget.dart';

class AdminOrderManagementScreen extends StatelessWidget {
  const AdminOrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final orders = AdminOrderManagementDummyData.sampleOrders;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: colors.screenBackground,
        appBar: AppBar(
          backgroundColor: colors.screenBackground,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Order Management',
            style: TextStyle(color: colors.primaryText, fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            icon: Icon(Icons.search, color: colors.appBarIcon),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list, color: colors.appBarIcon),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: colors.bottomNavActive,
            labelColor: colors.bottomNavActive,
            unselectedLabelColor: colors.secondaryText,
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
          icon: Icon(Icons.add, color: colors.buttonText),
          label: Text(
            'Add new Recipe',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: colors.buttonText,
            ),
          ),
          backgroundColor: colors.buttonBg,
        ),
        body: TabBarView(
          children: [
            _buildOrderList(
              context,
              orders,
              null,
              colors.card,
              colors.primaryText,
              colors.secondaryText,
            ),
            _buildOrderList(
              context,
              orders,
              'New',
              colors.card,
              colors.primaryText,
              colors.secondaryText,
            ),
            _buildOrderList(
              context,
              orders,
              'Preparing',
              colors.card,
              colors.primaryText,
              colors.secondaryText,
            ),
            _buildOrderList(
              context,
              orders,
              'Delivered',
              colors.card,
              colors.primaryText,
              colors.secondaryText,
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
