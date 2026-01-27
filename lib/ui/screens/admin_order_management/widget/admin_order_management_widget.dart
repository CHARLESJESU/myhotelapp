import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../language/language_controller.dart';
import '../admin_order_management_dummydata.dart';

/// Order card widget for displaying order details
class OrderCard extends StatelessWidget {
  final OrderItem order;
  final Color cardBg;
  final Color primaryText;
  final Color secondaryText;

  const OrderCard({
    super.key,
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
        return AppColors.tagPreparing;
      case 'Delivered':
        return AppColors.tagDelivered;
      default:
        return AppColors.tagPreparing;
    }
  }

  String _getLocalizedStatus(String status) {
    switch (status) {
      case 'New':
        return Get.find<LanguageController>().tr('new');
      case 'Preparing':
        return Get.find<LanguageController>().tr('preparing');
      case 'Delivered':
        return Get.find<LanguageController>().tr('delivered');
      default:
        return status;
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
                      _getLocalizedStatus(order.status),
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

/// Status tag widget for order status display
class StatusTag extends StatelessWidget {
  final String status;

  const StatusTag({super.key, required this.status});

  Color _getStatusColor() {
    switch (status) {
      case 'New':
        return AppColors.tagNew;
      case 'Preparing':
        return AppColors.tagPreparing;
      case 'Delivered':
        return AppColors.tagDelivered;
      default:
        return AppColors.tagPreparing;
    }
  }

  String _getLocalizedStatus(String status) {
    switch (status) {
      case 'New':
        return Get.find<LanguageController>().tr('new');
      case 'Preparing':
        return Get.find<LanguageController>().tr('preparing');
      case 'Delivered':
        return Get.find<LanguageController>().tr('delivered');
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        _getLocalizedStatus(status),
        style: const TextStyle(
          color: AppColors.buttonText,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
