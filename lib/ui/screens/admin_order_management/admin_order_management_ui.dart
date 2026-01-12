import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/responsive_helper.dart';

import '../../router/routing.dart';
import 'admin_order_management_dummydata.dart';
import 'widget/admin_order_management_widget.dart';

class AdminOrderManagementScreen extends StatefulWidget {
  const AdminOrderManagementScreen({super.key});

  @override
  State<AdminOrderManagementScreen> createState() => _AdminOrderManagementScreenState();
}

class _AdminOrderManagementScreenState extends State<AdminOrderManagementScreen> {
  @override
  void initState() {
    super.initState();
    // Record that the user is on the admin order management screen

  }



  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // Get responsive values
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.025,
      16,
      20,
    );
    final tabFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      0.02,
      14,
      16,
    );

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
            style: TextStyle(
              color: colors.primaryText,
              fontWeight: FontWeight.w700,
              fontSize: titleFontSize,
            ),
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
            tabs: [
              Tab(
                child: Text('All', style: TextStyle(fontSize: tabFontSize)),
              ),
              Tab(
                child: Text('New', style: TextStyle(fontSize: tabFontSize)),
              ),
              Tab(
                child: Text(
                  'Preparing',
                  style: TextStyle(fontSize: tabFontSize),
                ),
              ),
              Tab(
                child: Text(
                  'Delivered',
                  style: TextStyle(fontSize: tabFontSize),
                ),
              ),
            ],
          ),
        ),
        // centered "Add new Recipe" button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed(AppRoutes.addRecipe),
          icon: Icon(Icons.add, color: colors.buttonText),
          label: Text(
            'Add new Recipe',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: colors.buttonText,
              fontSize: ResponsiveHelper.getResponsiveFontSize(
                context,
                0.02,
                14,
                16,
              ),
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
      padding: EdgeInsets.all(
        ResponsiveHelper.getResponsiveSpacing(context, 0.02, 12, 20),
      ),
      itemCount: list.length,
      separatorBuilder: (_, __) => SizedBox(
        height: ResponsiveHelper.getResponsiveSpacing(context, 0.015, 8, 16),
      ),
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
