import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'add_recipe_screen.dart';

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

    final orders = _sampleOrders;

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
        return _OrderCard(
          order: order,
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText,
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderItem order;
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;

  const _OrderCard({
    required this.order,
    required this.cardBg,
    required this.primaryText,
    required this.secondaryText,
  });

  Color _statusColor(String s) {
    switch (s) {
      case 'New':
        return AppColors.tagNew;
      case 'Preparing':
        return AppColors.tagPreparing; // yellow-ish
      case 'Delivered':
        return AppColors.tagDelivered;
      default:
        return AppColors.tagPreparing;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  order.name,
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    order.time,
                    style: TextStyle(color: secondaryText, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(order.status),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      order.status,
                      style: const TextStyle(
                        color: AppColors.buttonText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: AppColors.adminDivider),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: order.items
                .map(
                  (it) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      it,
                      style: TextStyle(color: primaryText, fontSize: 16),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.adminDivider),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: secondaryText, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            order.address,
                            style: TextStyle(color: secondaryText),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone, color: secondaryText, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          order.phone,
                          style: TextStyle(color: secondaryText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '\$${order.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderItem {
  final String name;
  final String time;
  final List<String> items;
  final String address;
  final String phone;
  final double price;
  final String status;

  OrderItem({
    required this.name,
    required this.time,
    required this.items,
    required this.address,
    required this.phone,
    required this.price,
    required this.status,
  });
}

final List<OrderItem> _sampleOrders = [
  OrderItem(
    name: 'John Doe',
    time: '12:30 PM, Oct 26',
    items: ['2x Classic Burger', '1x Fries'],
    address: '123 Main St, Anytown, USA',
    phone: '(123) 456-7890',
    price: 25.50,
    status: 'New',
  ),
  OrderItem(
    name: 'Jane Smith',
    time: '12:25 PM, Oct 26',
    items: ['1x Pepperoni Pizza'],
    address: '456 Oak Ave, Anytown, USA',
    phone: '(987) 654-3210',
    price: 18.00,
    status: 'Preparing',
  ),
  OrderItem(
    name: 'Sam Wilson',
    time: '12:15 PM, Oct 26',
    items: ['3x Tacos', '1x Guacamole'],
    address: '789 Pine Ln, Anytown, USA',
    phone: '(555) 123-4567',
    price: 22.75,
    status: 'Delivered',
  ),
];
